#! /bin/bash

set -eo pipefail
set -x

if [[ "$CA_DIRECTORY" = "" ]]; then
  echo "CA_DIRECTORY env variable must be set"
  exit 1
fi

mkdir -p "$CA_DIRECTORY"
cd "$CA_DIRECTORY"

# CA
openssl genrsa -out ca-key.pem 4096
openssl req -new -x509 -days 3650 -key ca-key.pem -sha256 -out ca.pem

chmod go=r ca.pem
chmod go-rwx ca-key.pem
