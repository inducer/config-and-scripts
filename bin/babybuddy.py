from requests import Session


class JsonAPI:
    def __init__(self, base_url, key):
        self.base_url = base_url
        self.key = key
        self.session = Session()

    def _request(self, method, endpoint, *, json=None, params=None):
        headers = {"Authorization": f"{self.auth_type} {self.key}"}

        kwargs = {}
        if params:
            kwargs["params"] = params

        if json is not None:
            from json import dumps
            kwargs["data"] = dumps(json)
            headers["Content-Type"]  = "application/json"

        r = self.session.request(
                method=method,
                url=(self.base_url + endpoint),
                headers=headers,
                **kwargs,
                )
        if r.status_code != 200:
            print(r.content)
            r.raise_for_status()
        return r


class BabyBuddyAPI(JsonAPI):
    auth_type = "Token"

    def __init__(self, base_url, key):
        super().__init__(base_url=base_url + "/api", key=key)

    def describe(self, endpoint):
        return self._request("OPTIONS", endpoint).json()

    def children(self):
        return self._request("GET", "/children/").json()

    def add_feeding(self, data):
        return self._request("POST", "/feedings/", json=data)

    def add_sleep(self, data):
        return self._request("POST", "/sleep/", json=data)

    def add_change(self, data):
        return self._request("POST", "/changes/", json=data)

    def add_note(self, data):
        return self._request("POST", "/notes/", json=data)
