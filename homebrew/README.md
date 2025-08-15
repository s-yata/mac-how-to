# Homebrew

パッケージの管理は面倒なので， Homebrew を使えるようにします．
公式サイトに書いてある方法はスルーして，最新版のアーカイブをダウンロードします．

- macOS（またはLinux）用パッケージマネージャー — Homebrew
  - https://brew.sh/ja/
- Release latest · Homebrew/brew
  - https://github.com/Homebrew/brew/releases/latest

```
~ % mkdir packages

~ % cd packages

packages % curl -LO https://github.com/Homebrew/brew/archive/refs/tags/4.6.3.tar.gz
```

ダウンロードしたアーカイブを展開して，適当な位置に移動します．

```
packages % tar zxf 4.6.3.tar.gz

packages % brew-4.6.3 ~
```

後は，環境変数を設定すれば使える状態になります．

```
~ % ~/brew-4.6.3/bin/brew shellenv >> ~/.zshrc

~ % vi ~/.zshrc
...
export HOMEBREW_PREFIX="${HOME}/brew-4.6.3";
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
fpath[1,0]="${HOMEBREW_PREFIX}/share/zsh/site-functions";
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

~ % source ~/.zshrc
```

`brew doctor` で診断してもらうと Warning が出ますが，これについては仕方がないので見なかったことにします．

```
elasticsearch@m4-mac-mini ~ % brew doctor
==> Downloading https://ghcr.io/v2/homebrew/portable-ruby/portable-ruby/blobs/sha256:20fa657858e44a4b39171d6e4111f8a9716eb62a78ebbd1491d94f90bb7b830a
######################################################################### 100.0%
==> Pouring portable-ruby-3.4.5.arm64_big_sur.bottle.tar.gz
==> Downloading https://formulae.brew.sh/api/cask.jws.json
==> Downloading https://formulae.brew.sh/api/formula.jws.json
==> Downloading https://formulae.brew.sh/api/formula_tap_migrations.jws.json
Please note that these warnings are just used to help the Homebrew maintainers
with debugging if you file an issue. If everything you use Homebrew for is
working fine: please don't worry or file an issue; just ignore this. Thanks!

Warning: Your Homebrew's prefix is not /opt/homebrew.

Most of Homebrew's bottles (binary packages) can only be used with the default prefix.
Consider uninstalling Homebrew and reinstalling into the default prefix.

This is a Tier 3 configuration:
  https://docs.brew.sh/Support-Tiers#tier-3
You can report Tier 3 unrelated issues to Homebrew/* repositories!
Read the above document instead before opening any issues or PRs.
```
