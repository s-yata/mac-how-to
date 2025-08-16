#!/usr/bin/env python3

import json
from llama_cpp import Llama

llm = Llama(
  model_path="./gemma-3-270m-it-qat-Q4_0.gguf",
  verbose=False,
)

output = llm.create_completion(
  "Q: 太陽はどの方角から上りますか？ A: ",
  max_tokens=64,
  stop=["Q:", "\n"],
  echo=True
)

print(json.dumps(output, ensure_ascii=False))
