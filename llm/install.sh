#! /bin/bash

set -euo pipefail

rm -Rf ~/vllm/.venv
cd ~/vllm
uv venv --python 3.12 --seed
source .venv/bin/activate

cd ~/pack
git clone https://github.com/vllm-project/vllm.git --depth 1 || true
cd vllm

git checkout -f

# # https://github.com/vllm-project/vllm/pull/31607
# curl https://patch-diff.githubusercontent.com/raw/vllm-project/vllm/pull/31607.diff  | patch -p1

# uv pip install .[audio] --torch-backend=auto

uv pip install vllm[audio] --torch-backend=auto
