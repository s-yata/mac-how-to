# Command Line Tools for Xcode

Command Line Tools は Admin 権限がなくても以下のコマンドからインストールできます．
ただし，インストールの意思を確認するダイアログを出すコマンドなので， ssh でログインした状態で実行しても失敗します．
Command Line Tools がインストールされていない状態で clang や git を実行しようとしたときも同じダイアログが表示されるため，以下のコマンドを覚えておく必要はありません．

```
$ xcode-select --install
```

Command Line Tools がインストールされると，ほかのユーザも clang や git を使えるようになります．
後からインストールされて混乱する事態を避けるため，最初にインストールしてしまいましょう．

```
elasticsearch@m4-mac-mini ~ % clang --version
Apple clang version 17.0.0 (clang-1700.0.13.5)
Target: arm64-apple-darwin24.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```

```
elasticsearch@m4-mac-mini ~ % git --version
git version 2.39.5 (Apple Git-154)
```

ちなみに， gcc も呼び出せますが，中身は clang になっています．

```
elasticsearch@m4-mac-mini ~ % gcc --version
Apple clang version 17.0.0 (clang-1700.0.13.5)
Target: arm64-apple-darwin24.6.0
Thread model: posix
InstalledDir: /Library/Developer/CommandLineTools/usr/bin
```
