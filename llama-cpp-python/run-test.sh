#!/usr/bin/env bash

set -eu

MODEL_NAME="gemma-3-270m-it-qat-Q4_0.gguf"
MODEL_URL="https://huggingface.co/ggml-org/gemma-3-270m-it-qat-GGUF/resolve/main/gemma-3-270m-it-qat-Q4_0.gguf?download=true"

if [ -f "./${MODEL_NAME}" ]; then
  echo "Model (${MODEL_NAME}) already exists."
else
  curl -L -o "${MODEL_NAME}" "${MODEL_URL}"
fi

source venv/bin/activate

./sample.py

deactivate
