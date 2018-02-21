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

利用ライブラリは以下。

Library|License|Copyright
-------|-------|---------
[requests](http://requests-docs-ja.readthedocs.io/en/latest/)|[Apache-2.0](https://opensource.org/licenses/Apache-2.0)|[Copyright 2012 Kenneth Reitz](http://requests-docs-ja.readthedocs.io/en/latest/user/intro/#requests)
[dataset](https://dataset.readthedocs.io/en/latest/)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2013, Open Knowledge Foundation, Friedrich Lindenberg, Gregor Aisch](https://github.com/pudo/dataset/blob/master/LICENSE.txt)
[bs4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)|[MIT](https://opensource.org/licenses/MIT)|[Copyright © 1996-2011 Leonard Richardson](https://pypi.python.org/pypi/beautifulsoup4),[参考](http://tdoc.info/beautifulsoup/)
[pytz](https://github.com/newvem/pytz)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2003-2005 Stuart Bishop <stuart@stuartbishop.net>](https://github.com/newvem/pytz/blob/master/LICENSE.txt)
[PyYAML](https://github.com/yaml/pyyaml)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2006 Kirill Simonov](https://github.com/yaml/pyyaml/blob/master/LICENSE)
[pyotp](https://github.com/pyotp/pyotp)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (C) 2011-2017 Mark Percival m@mdp.im, Nathan Reynolds email@nreynolds.co.uk, Andrey Kislyuk kislyuk@gmail.com, and PyOTP contributors](https://github.com/pyotp/pyotp/blob/master/LICENSE)
[SQLAlchemy](https://www.sqlalchemy.org/)|[MIT](https://opensource.org/licenses/MIT)|[Mike Bayer](https://pypi.python.org/pypi/SQLAlchemy/1.2.2)
[furl](https://github.com/gruns/furl)|[Unlicense](http://unlicense.org/)|[gruns/furl](https://github.com/gruns/furl/blob/master/LICENSE.md)

以下、依存ライブラリ。

Library|License|Copyright
-------|-------|---------
[alembic](https://github.com/zzzeek/alembic)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (C) 2009-2018 by Michael Bayer.](https://github.com/zzzeek/alembic/blob/master/LICENSE)
[banal](https://github.com/pudo/banal)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2017 Friedrich Lindenberg](https://github.com/pudo/banal/blob/master/LICENSE)
[certifi](https://github.com/certifi/python-certifi)|[MPL2.0](https://www.mozilla.org/en-US/MPL/2.0/)|[MPL2.0](https://github.com/certifi/python-certifi/blob/master/LICENSE)
[chardet](https://github.com/chardet/chardet)|[LGPL2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.ja.html)|[Copyright (C) 1991, 1999 Free Software Foundation, Inc.](https://github.com/chardet/chardet/blob/master/LICENSE)
[idna](https://github.com/kjd/idna)|All rights reserved.|[Copyright (c) 2013-2017, Kim Davies. All rights reserved.](https://github.com/kjd/idna/blob/master/LICENSE.rst)
[mako](https://github.com/zzzeek/mako)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (C) 2006-2016 the Mako authors and contributors see AUTHORS file.](https://github.com/zzzeek/mako/blob/master/LICENSE)
[normality](https://github.com/pudo/normality)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2013, Open Knowledge Foundation, Friedrich Lindenberg, Gregor Aisch](https://github.com/pudo/normality/blob/master/LICENSE)
[dateutil](https://pypi.python.org/pypi/python-dateutil/2.6.1)|[Simplified BSD](https://opensource.org/licenses/BSD-2-Clause)|[© Copyright 2016, dateutil.](https://dateutil.readthedocs.io/en/stable/)
[python-editor](https://github.com/fmoo/python-editor)|[Apache License 2.0](https://opensource.org/licenses/Apache-2.0)|[fmoo/python-editor](https://github.com/fmoo/python-editor/blob/master/LICENSE)
[six](https://pypi.python.org/pypi/six)|[MIT](https://opensource.org/licenses/MIT)|[Copyright (c) 2010-2018 Benjamin Peterson](https://github.com/benjaminp/six/blob/master/LICENSE)

