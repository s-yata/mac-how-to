# Java

デフォルトの状態では Java を起動しようとすると以下のように失敗します．

```
% java       
The operation couldn’t be completed. Unable to locate a Java Runtime.
Please visit http://www.java.com for information on installing Java.
```

メッセージ中の URL からダウンロードできるのは Oracle Java です．
「個人的な使用や開発目的での使用など、特定の使用が無償で許可」となっていますが，用途によっては有償になります．

油断して無償で使用できる範囲から外れるのが怖いため，無償の OpenJDK を使います．
以下のウェブサイトから macOS / AArch64 用のアーカイブをダウンロードして展開します．

- OpenJDK
  - https://openjdk.org/

```
~ % curl -LO https://download.java.net/java/GA/jdk24.0.2/fdc5d0102fe0414db21410ad5834341f/12/GPL/openjdk-24.0.2_macos-aarch64_bin.tar.gz

~ % tar zxf openjdk-24.0.2_macos-aarch64_bin.tar.gz
```

後は環境変数 `JAVA_HOME` を設定すれば使えるようになります．

```
~ % vi ~/.zshrc
...
export JAVA_HOME="${HOME}/jdk-24.0.2.jdk/Contents/Home"

~ % source ~/.zshrc

~ % java --version
openjdk 24.0.2 2025-07-15
OpenJDK Runtime Environment (build 24.0.2+12-54)
OpenJDK 64-Bit Server VM (build 24.0.2+12-54, mixed mode, sharing)
```
