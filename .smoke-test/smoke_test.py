#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.10"
# dependencies = [
#   "httpx",
#   "fastapi",
#   "pydantic",
#   "PyYAML",
#   "typed_argparse",
#   "uvicorn",
# ]
# ///
"""Smoke test for the OpenAI-compatible proxy (run against a built-in fake
vLLM backend).

Starts a fake backend and the proxy under test on loopback, then verifies the
authentication and header-passthrough behavior:

  - unauthenticated requests reach no backend at all
  - /docs, /redoc, and /openapi.json are not served
  - malformed Authorization headers yield 401/403, never 500
  - the client's API key is never forwarded to the backend
  - X-Forwarded-For / X-Real-IP reflect the direct peer, hop-by-hop and
    proxy headers are stripped
  - streaming and non-streaming responses (including upstream errors) are
    passed through with the correct status codes
  - model allow-listing and the request-body size limit are enforced

Usage:
    uv run smoke_test.py                 # self-contained (uses uv)
    python3 smoke_test.py                # or with a prepared interpreter

    --proxy PATH       proxy script under test
                       (default: <this dir>/../llm/openai-proxy)
    --backend-port N   fixed port for the fake backend (default: ephemeral)
    --proxy-port N     fixed port for the proxy (default: ephemeral)

Exit status: 0 if all checks pass, 1 otherwise (CI-friendly).
"""
import argparse
import json
import os
import socket
import subprocess
import sys
import tempfile
import threading
import time

import http.server
import httpx


def make_backend(port: int):
    """A minimal stand-in for a vLLM server that logs every request it sees."""

    class H(http.server.BaseHTTPRequestHandler):
        def log_message(self, *args):
            pass

        def _send(self, code, obj):
            body = json.dumps(obj).encode()
            self.send_response(code)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

        def do_GET(self):
            backend_log.append({"method": "GET", "path": self.path})
            if self.path == "/v1/models":
                self._send(200, {"object": "list", "data": [
                    {"id": "model-a", "object": "model"},
                    {"id": "other-model", "object": "model"},
                ]})
            else:
                self._send(404, {"error": "not found"})

        def do_POST(self):
            n = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(n).decode()
            backend_log.append({
                "method": "POST", "path": self.path,
                "auth": self.headers.get("Authorization"),
                "xff": self.headers.get("X-Forwarded-For"),
                "xri": self.headers.get("X-Real-IP"),
                "te": self.headers.get("Te"),
                "pauth": self.headers.get("Proxy-Authorization"),
                "body": body,
            })
            data = json.loads(body)
            model = data.get("model")
            if model == "model-a":
                if data.get("stream"):
                    self.send_response(200)
                    self.send_header("Content-Type", "text/event-stream")
                    self.end_headers()
                    for i in range(3):
                        self.wfile.write(f'{{"i": {i}}}'.encode())
                        self.wfile.write(b"\n\n")
                    self.wfile.write(b"data: [DONE]\n\n")
                else:
                    self._send(200, {
                        "id": "c1", "object": "chat.completion",
                        "choices": [{"message": {"content": "hello from backend"}}],
                    })
            else:
                self._send(
                    404, {"error": {"message": f"model '{model}' not found"}})

    return http.server.ThreadingHTTPServer(("127.0.0.1", port), H)


def free_port() -> int:
    """Ask the OS for a free loopback port (best effort)."""
    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def raw_status(port: int, raw_request: bytes) -> str:
    """Send a raw HTTP request and return the response status line."""
    s = socket.create_connection(("127.0.0.1", port), timeout=10)
    s.sendall(raw_request)
    s.shutdown(socket.SHUT_WR)
    data = b""
    while True:
        chunk = s.recv(65536)
        if not chunk:
            break
        data += chunk
    s.close()
    return data.split(b"\r\n", 1)[0].decode()


backend_log = []
results = []  # (name, passed, extra)


def check(name, cond, extra=""):
    ok = bool(cond)
    results.append((name, ok, "" if ok else str(extra)))
    print(f"[{'PASS' if ok else 'FAIL'}] {name}"
          + (f"  -- {extra}" if not ok else ""))


def parse_args():
    here = os.path.dirname(os.path.abspath(__file__))
    p = argparse.ArgumentParser(
        description="Smoke test for the OpenAI-compatible proxy")
    p.add_argument(
        "--proxy",
        default=os.path.normpath(os.path.join(here, "..", "llm", "openai-proxy")),
        help="path to the proxy script under test")
    p.add_argument("--backend-port", type=int, default=0,
                   help="fixed port for the fake backend (default: ephemeral)")
    p.add_argument("--proxy-port", type=int, default=0,
                   help="fixed port for the proxy (default: ephemeral)")
    return p.parse_args()


def main():
    args = parse_args()
    backend_port = args.backend_port or free_port()
    proxy_port = args.proxy_port or free_port()
    base = f"http://127.0.0.1:{proxy_port}"
    valid_key = "test-client-key"

    tmpdir = tempfile.TemporaryDirectory(prefix="openai-proxy-smoke-")
    config = os.path.join(tmpdir.name, "test-proxy.yaml")
    with open(config, "w") as f:
        f.write(f"""listen_host: "127.0.0.1"
listen_port: {proxy_port}
backends:
  be1:
    base_url: http://127.0.0.1:{backend_port}
    api_key: UPSTREAM_KEY
client_keys:
  test-client-key:
    allowed_models:
    - "model*"
""")

    server = make_backend(backend_port)
    threading.Thread(target=server.serve_forever, daemon=True).start()

    # sys.executable guarantees the proxy gets the same dependencies as
    # this test (relevant when this file is run via `uv run`).
    proxy = None
    out = ""
    try:
        try:
            proxy = subprocess.Popen(
                [sys.executable, args.proxy, config],
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        except OSError as e:
            raise RuntimeError(f"could not start proxy {args.proxy!r}: {e}")

        client = httpx.Client(timeout=10)

        # wait for the proxy to come up
        up = False
        for _ in range(50):
            try:
                r = client.get(f"{base}/v1/models")
                if r.status_code in (401, 403):
                    up = True
                    break
            except httpx.HTTPError:
                time.sleep(0.2)
        if not up:
            raise RuntimeError("proxy did not come up")

        # 1: unauthenticated GET /v1/models must not hit the backend
        backend_log.clear()
        r = client.get(f"{base}/v1/models")
        check("1a unauth /v1/models -> 401", r.status_code == 401, r.text)
        check("1b unauth /v1/models triggers no backend call",
              not backend_log, str(backend_log))

        # 2: wrong key
        backend_log.clear()
        r = client.get(f"{base}/v1/models",
                       headers={"Authorization": "Bearer wrong-key"})
        check("2a wrong key /v1/models -> 403", r.status_code == 403, r.text)
        check("2b wrong key triggers no backend call", not backend_log,
              str(backend_log))

        # 3: docs / OpenAPI must not be served
        for path in ("/docs", "/redoc", "/openapi.json"):
            r = client.get(f"{base}{path}")
            check(f"3 {path} -> 404", r.status_code == 404, str(r.status_code))

        # 4: 'Bearer ' with no key must be 401, not 500
        # (sent via raw socket: the httpx client refuses to send such a
        # header, but a real attacker is not limited by that)
        status = raw_status(proxy_port, (
            b"GET /v1/models HTTP/1.1\r\n"
            b"Host: 127.0.0.1\r\n"
            b"Authorization: Bearer \r\n"
            b"\r\n"))
        check("4 'Bearer ' (no key) -> 401", " 401 " in status, status)

        # 5: non-ASCII key must be 403, not 500 (raw UTF-8 'Bearer Béarér')
        status = raw_status(proxy_port, (
            b"GET /v1/models HTTP/1.1\r\n"
            b"Host: 127.0.0.1\r\n"
            b"Authorization: Bearer B\xc3\xa9ar\xc3\xa9r\r\n"
            b"\r\n"))
        check("5 non-ASCII key -> 403", " 403 " in status, status)

        # 6: unauthenticated POST must not hit the backend
        backend_log.clear()
        r = client.post(f"{base}/v1/chat/completions",
                        json={"model": "model-a"})
        check("6a unauth POST -> 401", r.status_code == 401, r.text)
        check("6b unauth POST triggers no backend call", not backend_log,
              str(backend_log))

        # 7: valid non-streaming request
        backend_log.clear()
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}",
                     "X-Forwarded-For": "6.6.6.6",
                     "X-Real-IP": "7.7.7.7",
                     "Te": "trailers",
                     "Proxy-Authorization": "Basic abc"},
            json={"model": "model-a"})
        check("7a valid request -> 200", r.status_code == 200, r.text)
        check("7b response body passed through",
              r.json().get("choices", [{}])[0].get("message", {})
              .get("content") == "hello from backend", r.text)
        entry = backend_log[-1] if backend_log else {}
        check("7c backend got the upstream key, not the client key",
              entry.get("auth") == "Bearer UPSTREAM_KEY", str(entry))
        check("7d x-forwarded-for appended with direct peer",
              entry.get("xff") == "6.6.6.6, 127.0.0.1", str(entry))
        check("7e x-real-ip overwritten", entry.get("xri") == "127.0.0.1",
              str(entry))
        check("7f hop-by-hop / proxy headers stripped",
              entry.get("te") is None and entry.get("pauth") is None,
              str(entry))

        # 8: valid streaming request
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            json={"model": "model-a", "stream": True})
        check("8a stream -> 200", r.status_code == 200, r.text[:200])
        check("8b stream body passed through",
              "data: [DONE]" in r.text and '{"i": 0}' in r.text, r.text[:200])

        # 9: backend error must keep its status code (stream + non-stream)
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            json={"model": "model-unknown-xyz"})
        check("9a non-stream backend 404 passed through",
              r.status_code == 404 and "not found" in r.text,
              f"{r.status_code} {r.text}")
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            json={"model": "model-unknown-xyz", "stream": True})
        check("9b stream backend 404 passed through with status",
              r.status_code == 404 and "not found" in r.text,
              f"{r.status_code} {r.text[:200]}")

        # 10: allowed-by-pattern but not on any backend -> 404, no backend call
        backend_log.clear()
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            json={"model": "model-b"})
        check("10a missing model -> 404 'Model not found'",
              r.status_code == 404 and "Model not found" in r.text,
              f"{r.status_code} {r.text}")
        check("10b no backend call for missing model", not backend_log,
              str(backend_log))

        # 11: non-object JSON body -> 400, not 500
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            content=b"[]")
        check("11 json array body -> 400", r.status_code == 400,
              f"{r.status_code} {r.text}")

        # 12: model not allowed for this key
        backend_log.clear()
        r = client.post(
            f"{base}/v1/chat/completions",
            headers={"Authorization": f"Bearer {valid_key}"},
            json={"model": "other-model"})
        check("12a disallowed model -> 403", r.status_code == 403,
              f"{r.status_code} {r.text}")
        check("12b no backend call for disallowed model", not backend_log,
              str(backend_log))

        # 13: authenticated model list is filtered per client
        r = client.get(f"{base}/v1/models",
                       headers={"Authorization": f"Bearer {valid_key}"})
        ids = [m.get("id") for m in r.json().get("data", [])]
        check("13 /v1/models filtered to allowed models", ids == ["model-a"],
              str(ids))

        # 14: lying content-length -> 413 before the body is read
        auth_line = f"Authorization: Bearer {valid_key}\r\n".encode()
        status = raw_status(proxy_port, (
            b"POST /v1/chat/completions HTTP/1.1\r\n"
            b"Host: 127.0.0.1\r\n"
            + auth_line +
            b"Content-Length: 999999999\r\n"
            b"\r\n"))
        check("14 oversized content-length -> 413", " 413 " in status, status)

        client.close()
    except Exception as e:
        check("no unexpected error", False, repr(e))
    finally:
        if proxy is not None:
            proxy.terminate()
            try:
                out, _ = proxy.communicate(timeout=10)
            except subprocess.TimeoutExpired:
                proxy.kill()
                out, _ = proxy.communicate()
        server.shutdown()
        server.server_close()
        tmpdir.cleanup()

    print()
    passed = sum(1 for _, ok, _ in results if ok)
    if passed != len(results):
        print(f"RESULT: FAIL ({passed}/{len(results)} checks passed)")
        print("--- proxy output ---")
        print(out or "(no output)")
        sys.exit(1)
    print(f"RESULT: PASS ({len(results)} checks passed)")


if __name__ == "__main__":
    main()
