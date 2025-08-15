# SSH

SSH はサーバ，クライアントともにデフォルトでインストールされています．

## SSH サーバ

以下のページに ssh でログインできるようにする方法の説明があります．

- リモートコンピュータにMacへのアクセスを許可する - Apple サポート (日本)
  - https://support.apple.com/ja-jp/guide/mac-help/mchlp1066/mac

システム設定，一般，共有，リモートログインと進めば設定できます．

リモートログインを有効にすると，パスワードによるログインが可能になります．
外に外に持ち出して使用する端末では，リモートログイン自体を無効にしておく方が安全です．

## SSH クライアント

リモートログインが有効であれば，パスワードによるログインが可能です．

```
$ ssh hostname.local
(username@hostname.local) Password:
Last login: Fri Aug 15 14:11:20 2025 from 192.168.100.10

%
```

パスワードの入力が面倒であれば，公開鍵を登録しておくと省略できて楽になります．

```
$ ssh-copy-id -i ~/.ssh/id_ed25519.pub username@hostname.local
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/username/.ssh/id_ed25519.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
(username@hostname.local) Password:
```

デフォルトのログインシェルは zsh になっています．
メインの開発環境として使っている Ubuntu からログインすると挙動が違って混乱するため，よく使う操作については設定をできる範囲で合わせておきます．

```
% vi ~/.zshrc
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
```
