# OpenMP (libomp)

[Homebrew](../homebrew) を使って OpenMP をインストールします．

- Home - OpenMP
  - https://www.openmp.org/

```
~ % brew install libomp
```

CMake と組み合わせたときに libomp が見つからない問題があり，それを解決するには環境変数 `OpenMP_ROOT` が必要になるようです．

- CMake + Apple Clang で OpenMP 5 を使う
  - https://zenn.dev/arawii/articles/47a24cf2d0a3b2

```
~ % vi ~/.zshrc
...
export OpenMP_ROOT="${HOMEBREW_PREFIX}/opt/libomp"
```
