# llama-cpp-python

## インストール

pip3 を使って llama-cpp-python をインストールします．
前提として [OpenMP (libomp)](../openmp) が必要になります．

- abetlen/llama-cpp-python: Python bindings for llama.cpp
  - https://github.com/abetlen/llama-cpp-python

Python の環境を汚さないため， venv を利用します．

- venv — Creation of virtual environments — Python 3.13.7 documentation
  - https://docs.python.org/3/library/venv.html

```
~ % mkdir tmp

~ % cd tmp

tmp % python3 -m venv venv

tmp % source venv/bin/activate
```

準備が正しくできていれば，インストールは問題なく完了するはずです．

```
(venv) tmp % pip3 install llama-cpp-python
```

venv は deactivate で解除できます．

```
(venv) tmp % deactivate

tmp %
```

## 動作確認

気軽に試せる小規模なモデルが公開されたので， Gemma 3 270m で動作を確認します．

- Introducing Gemma 3 270M: The compact model for hyper-efficient AI - Google Developers Blog
  - https://developers.googleblog.com/ja/introducing-gemma-3-270m/

モデルをダウンロードして動作確認するシェルスクリプトを用意したので，それを問題なく実行できれば成功です．

```
llama-cpp-python % ./run-test.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1343  100  1343    0     0   5805      0 --:--:-- --:--:-- --:--:--  5813
100  230M  100  230M    0     0  10.7M      0  0:00:21  0:00:21 --:--:-- 10.6M
```
```json
{"id": "cmpl-8985e260-a994-4b10-8aa4-fc90a418b840", "object": "text_completion", "created": 1755320824, "model": "./gemma-3-270m-it-qat-Q4_0.gguf", "choices": [{"text": "Q: 太陽はどの方角から上りますか？ A: 太陽は、東側から南にあります。 B: 太陽は、南にあります。 C: 太陽は、北にあります。 D: 太陽は、西にあります。", "index": 0, "logprobs": null, "finish_reason": "stop"}], "usage": {"prompt_tokens": 17, "completion_tokens": 41, "total_tokens": 58}}
```
