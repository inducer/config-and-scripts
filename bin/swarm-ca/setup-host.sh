#! /bin/bash

if [[ -z "$1" ]]; then
  echo "usage: $0 hostname"
  exit 1
fi

set -eo pipefail
set -x

HOST="$1"
IP=$(python3 -c "import socket; print(socket.gethostbyname(\"$HOST\"))")

if [[ "$CA_DIRECTORY" = "" ]]; then
  echo "CA_DIRECTORY env variable must be set"
  exit 1
fi

cd "$CA_DIRECTORY"

KEYFILE="host-key-$HOST.pem"
CERTFILE="host-cert-$HOST.pem"

# Host
openssl genrsa -out "$KEYFILE" 4096
openssl req -subj "/CN=$HOST" -new -key "$KEYFILE" -out host.csr
echo subjectAltName = IP:$IP,IP:127.0.0.1 > extfile.cnf
openssl x509 -req -days 3650 -in host.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out $CERTFILE -extfile extfile.cnf

rm host.csr
rm extfile.cnf

chmod go-rwx "$CERTFILE" "$KEYFILE"
