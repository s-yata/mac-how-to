# llama-cpp-python

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

動作確認までできればいいのですが，モデルが大きいのでここで終わりにします．

venv は deactivate で解除できます．

```
(venv) tmp % deactivate

tmp %
```
