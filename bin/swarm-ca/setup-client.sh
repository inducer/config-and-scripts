#! /bin/bash

set -eo pipefail
set -x

if [[ "$CA_DIRECTORY" = "" ]]; then
  echo "CA_DIRECTORY env variable must be set"
  exit 1
fi

cd "$CA_DIRECTORY"

# Client
openssl genrsa -out client-key.pem 4096
openssl req -subj '/CN=client' -new -key client-key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 3650 -in client.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out client-cert.pem -extfile extfile.cnf

rm client.csr
rm extfile.cnf
