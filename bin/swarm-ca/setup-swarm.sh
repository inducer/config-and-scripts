#! /bin/bash

set -eo pipefail
set -x

if [[ "$CA_DIRECTORY" = "" ]]; then
  echo "CA_DIRECTORY env variable must be set"
  exit 1
fi

cd "$CA_DIRECTORY"

# Swarm
openssl genrsa -out swarm-key.pem 4096
openssl req -subj "/CN=relate.cs.illinois.edu" -sha256 -new -key swarm-key.pem -out swarm.csr
echo subjectAltName = DNS:relate.cs.illinois.edu,IP:130.126.112.202,IP:127.0.0.1 > extfile.cnf
echo extendedKeyUsage = clientAuth,serverAuth >> extfile.cnf
openssl x509 -req -days 3650 -sha256 -in swarm.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out swarm-cert.pem -extfile extfile.cnf

rm swarm.csr
rm extfile.cnf

chmod g=r,o-rwx swarm-key.pem
