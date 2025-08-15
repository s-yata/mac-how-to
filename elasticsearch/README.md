# Elasticsearch

Elasticsearch をインストールする方法はいくつかありますが，ソースコードからビルドします．

## ソースコードをビルド

GitHub からアーカイブをダウンロードして展開します．

- Releases · elastic/elasticsearch
  - https://github.com/elastic/elasticsearch/releases

```
~ % mkdir packages

~ % cd packages

packages % curl -LO https://github.com/elastic/elasticsearch/archive/refs/tags/v9.1.2.tar.gz

packages % tar zxf v9.1.2.tar.gz

packages % cd elasticsearch-9.1.2
```

さっそくビルドしたいところですが， Java が使えないとビルドできません．
以下のようにエラーメッセージが出て失敗します．

```
elasticsearch-9.1.2 % ./gradlew localDistro
The operation couldn’t be completed. Unable to locate a Java Runtime.
Please visit http://www.java.com for information on installing Java.
```

[Java のインストール方法](../java)を参考に， Java を使える状態にした後，以下のコマンドでビルドが開始します．
ビルド中に Elasticsearch 用の OpenJDK がダウンロードされるため， Java のインストールが無駄に感じてしまいますが，仕方ありません．

```
elasticsearch-9.1.2 % ./gradlew localDistro
...
=======================================
Elasticsearch Build Hamster says Hello!
  Gradle Version        : 8.14.2
  OS Info               : Mac OS X 15.6 (aarch64)
  JDK Version           : 21.0.7+6-LTS (Eclipse Temurin)
  JAVA_HOME             : /Users/elasticsearch/.gradle/jdks/eclipse_adoptium-21-aarch64-os_x.2/jdk-21.0.7+6/Contents/Home
  Random Testing Seed   : 8249D965385AAFB7
  In FIPS 140 mode      : false
=======================================
...
Elasticsearch distribution installed to /Users/elasticsearch/elasticsearch-9.1.2/build/distribution/local/elasticsearch-9.1.2-SNAPSHOT

[Incubating] Problems report is available at: file:///Users/elasticsearch/elasticsearch-9.1.2/build/reports/problems/problems-report.html
```

以上でビルドは終わりです．

ビルドした Elasticsearch を適当な場所に移動して， Elasticsearch が参照する環境変数 `ES_HOME` と `PATRH` を設定します．
今回は `${HOME}/elasticsearch-9.1.2` にしました．

```
elasticsearch-9.1.2 % mv build/distribution/local/elasticsearch-9.1.2-SNAPSHOT ~/elasticsearch-9.1.2

elasticsearch-9.1.2 % vi ~/.zshrc
...
export ES_HOME="${HOME}/elasticsearch-9.1.2"
export PATH="${ES_HOME}/bin:${PATH}"

elasticsearch-9.1.2 % source ~/.zshrc
```

まずは一度起動して，必要なファイルを生成します．

```
~ % elasticsearch
...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Elasticsearch security features have been automatically configured!
✅ Authentication is enabled and cluster connections are encrypted.

ℹ️  Password for the elastic user (reset with `bin/elasticsearch-reset-password -u elastic`):
  WFDFz7y2bR_*cLRuxdr5

ℹ️  HTTP CA certificate SHA-256 fingerprint:
  816cc3531ea45599f4cbe941a12b4c06265c8b7953fffe4e5e757b0bf086bec4

ℹ️  Configure Kibana to use this cluster:
• Run Kibana and click the configuration link in the terminal when Kibana starts.
• Copy the following enrollment token and paste it into Kibana in your browser (valid for the next 30 minutes):
  eyJ2ZXIiOiI4LjE0LjAiLCJhZHIiOlsiMTkyLjE2OC4xMDAuMjo5MjAwIl0sImZnciI6IjgxNmNjMzUzMWVhNDU1OTlmNGNiZTk0MWExMmI0YzA2MjY1YzhiNzk1M2ZmZmU0ZTVlNzU3YjBiZjA4NmJlYzQiLCJrZXkiOiJTWXFackpnQk5zZ3V5TGJtNTB4RjpmWHhHNlNCYnVhczdtbTNlb0FsZEt3In0=

ℹ️  Configure other nodes to join this cluster:
• On this node:
  ⁃ Create an enrollment token with `bin/elasticsearch-create-enrollment-token -s node`.
  ⁃ Uncomment the transport.host setting at the end of config/elasticsearch.yml.
  ⁃ Restart Elasticsearch.
• On other nodes:
  ⁃ Start Elasticsearch with `bin/elasticsearch --enrollment-token <token>`, using the enrollment token that you generated.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
...
```

設定ファイルを必要に応じて変更します．

- Configure Elasticsearch | Elastic Docs
  - https://www.elastic.co/docs/deploy-manage/deploy/self-managed/configure-elasticsearch

以下の例では，認証や HTTPS を使わないようにして，ローカルホスト以外からはアクセスできないようにしています．

```
~ % vi "${ES_HOME}/elasticsearch.yml"
...
xpack.security.enabled: false
...
http.host: 127.0.0.1
...
```

デフォルトの設定では， Elasticsearch は起動時にメモリの 50% を確保します．
用途によっては無駄になるので，必要に応じてメモリ使用量を制限します．

- JVM settings | Reference
  - https://www.elastic.co/docs/reference/elasticsearch/jvm-settings

たとえば， 2GB に制限するのであれば，以下のように設定します．

```
~ % vi "${ES_HOME}/config/jvm.options.d/heap-size.options"
-Xms2g
-Xmx2g
```

Elasticsearch を起動し直して HTTP クライアントで接続すれば，状態を確認できます．

```
~ % curl localhost:9200
```

```json
{
  "name" : "m4-mac-mini.local",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "Cc-bjKBDRP2F_ns69FBXpA",
  "version" : {
    "number" : "9.1.2-SNAPSHOT",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "unknown",
    "build_date" : "2025-08-15T06:56:04.057387Z",
    "build_snapshot" : true,
    "lucene_version" : "10.2.2",
    "minimum_wire_compatibility_version" : "8.19.0",
    "minimum_index_compatibility_version" : "8.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

以上でインストール完了です．

### プラグインをインストール

以下のページを参考に analysis-kuromoji をインストールしてみます．

- Japanese (kuromoji) analysis plugin | Reference
  - https://www.elastic.co/docs/reference/elasticsearch/plugins/analysis-kuromoji

プラグインのインストールは `elasticsearch-plugin` に名前だけを指定すればいいだけのはずですが，それでは失敗しました．

```
packages % elasticsearch-plugin install analysis-kuromoji
-> Installing analysis-kuromoji
-> Failed installing analysis-kuromoji
-> Rolling back analysis-kuromoji
-> Rolled back analysis-kuromoji

ERROR: attempted to install release build of official plugin on snapshot build of Elasticsearch, with exit code 78
```

このようなときは，ダウンロードしたアーカイブのパスを指定すれば大丈夫です．

```
packages % curl -LO https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-9.1.2.zip

packages % elasticsearch-plugin install "file://${HOME}/packages/analysis-kuromoji-9.1.2.zip"
-> Installing file:///Users/elasticsearch/packages/analysis-kuromoji-9.1.2.zip
-> Downloading file:///Users/elasticsearch/packages/analysis-kuromoji-9.1.2.zip
[=================================================] 100%   
WARNING: plugin has a policy file with no additional entitlements. Double check this is intentional.
-> Installed analysis-kuromoji
-> Please restart Elasticsearch to activate any plugins installed

packages % elasticsearch-plugin list
analysis-kuromoji
```

以上でインストール完了です．

## brew によるインストール

brew でインストールできるのは古い Elasticsearch です．
最新版は Elasticsearch 9 なのに， Elasticsearch 7 がインストールされてしまいます．
更新停止しているので使うべきではありません．

- Announcing the official Elastic Homebrew tap for macOS | Elastic Blog
  - https://www.elastic.co/blog/official-elastic-homebrew-tap-package-manager-macos
- elastic/homebrew-tap: Homebrew tap for the Elastic Stack
  - https://github.com/elastic/homebrew-tap

## アーカイブからインストール

Mac 向けのアーカイブが提供されていますが， "This package contains both free and subscription features. Start a 30-day trial to try out all of the features." と書かれているので却下しました．

- Install Elasticsearch from archive on Linux or MacOS | Elastic Docs
  - https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-from-archive-on-linux-macos
