#! /bin/bash

set -euo pipefail

uv venv --python 3.12 --seed
source .venv/bin/activate
uv pip install vllm[audio] --torch-backend=auto
git clone https://github.com/vllm-project/vllm.git vllm-git --depth 1
