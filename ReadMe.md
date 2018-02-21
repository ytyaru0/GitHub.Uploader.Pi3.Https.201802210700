# このソフトウェアについて

GitHubアップロードツール。

ラズパイ3で動作するよう改変した版。HTTPS版。

# 前回

* [GitHub.Uploader.Thread.Contributions.201707071556](https://github.com/ytyaru/GitHub.Uploader.Thread.Contributions.201707071556)

# ラズパイ3で動作するよう改変した版

ラズパイでSSH通信できなかったのでHTTPS通信に変えた。セキュリティ的に脆弱。

[改変した経緯](memo/経緯_20180221.md)

## 改変箇所

* なぜかSSH通信できなかった
    * HTTPS通信でpushするよう変更した
        * `./cui/uploader/command/repository/Creator.py`
    * gitコマンドログを出力するようにした
        * `./cui/uploader/command/repository/Creator.py`
        * `./cui/uploader/command/repository/Commiter.py`
* PIL(Pillow)を使ってないのにimport文があったのでコメントアウトした
    * `./web/http/Response.py`

余談だが、パッケージ `yaml` が Python3.6.4でインストールできなかったので、`pyyaml`にした。ソースコードは変えなくて大丈夫だった。

# 開発環境

## 今回

* [Raspberry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 3 Model B
    * [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) GNU/Linux 8.0 (jessie)
        * [pyenv](http://ytyaru.hatenablog.com/entry/2019/01/06/000000)
            * Python 3.6.4

## 改変前

* Linux Mint 17.3 MATE 32bit
* [Python 3.4.3](https://www.python.org/downloads/release/python-343/)
* [SQLite](https://www.sqlite.org/) 3.8.2

## WebService

* [GitHub](https://github.com/)
    * [アカウント](https://github.com/join?source=header-home)
    * [AccessToken](https://github.com/settings/tokens)
    * [Two-Factor認証](https://github.com/settings/two_factor_authentication/intro)
    * [API v3](https://developer.github.com/v3/)

# コマンド概要

コマンド|説明
--------|----
UserRegister.py|対象とするGitHubアカウントを本ツールに登録する。
Uploader.py|指定ディレクトリをリポジトリとして作成、アップロードする。
OtpCreator.py|指定ユーザのOTP(ワンタイムパスワード)をクリップボードにコピーする。

今回追加したコマンドは`./database/src/contributions/SvgCreator.py`。以下のように実行する。

# 準備

`UserRegister.py`でユーザ登録済みであること。

## 実行

[CallMe.sh](memo/CallMe.sh)参照。

```sh
#!/bin/bash
user=任意GitHubユーザ名
desc="任意リポジトリ説明文。"
url=http://リポジトリ説明の任意URL
target=$(cd $(dirname $0) && pwd)

script=/tmp/GitHub.Uploader.Pi3.Https.201802210700/src/Uploader.py
python3 ${script} "${target}" -u  "${user}" -d "${desc}" -l "${url}"
```

画面に従い操作する。

### 草SVG生成ツール

```python
$ bash ./src/database/contributions/outputsvg.sh
```

一度作成したら動作しないようになっている。is_overwriteフラグで指定可能。変更したければコード修正すること。

`GitHub.Contributions.{username}.{year}.svg`の書式で出力される。

# ライセンス

このソフトウェアはCC0ライセンスである。

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)

Library|License|Copyright
-------|-------|---------
[requests](http://requests-docs-ja.readthedocs.io/en/latest/)|[Apache-2.0](https://opensource.org/licenses/Apache-2.0)|[Copyright 2012 Kenneth Reitz](http://requests-docs-ja.readthedocs.io/en/latest/user/intro/#requests)
[dataset](https://dataset.readthedocs.io/en/latest/)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2013, Open Knowledge Foundation, Friedrich Lindenberg, Gregor Aisch](https://github.com/pudo/dataset/blob/master/LICENSE.txt)
[bs4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)|[MIT](https://opensource.org/licenses/MIT)|[Copyright © 1996-2011 Leonard Richardson](https://pypi.python.org/pypi/beautifulsoup4),[参考](http://tdoc.info/beautifulsoup/)
[pytz](https://github.com/newvem/pytz)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2003-2005 Stuart Bishop <stuart@stuartbishop.net>](https://github.com/newvem/pytz/blob/master/LICENSE.txt)
[furl](https://github.com/gruns/furl)|[Unlicense](http://unlicense.org/)|[gruns/furl](https://github.com/gruns/furl/blob/master/LICENSE.md)
[PyYAML](https://github.com/yaml/pyyaml)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2006 Kirill Simonov](https://github.com/yaml/pyyaml/blob/master/LICENSE)

