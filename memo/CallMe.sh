#!/bin/bash
user=任意GitHubユーザ名
desc="任意リポジトリ説明文。"
url=http://リポジトリ説明の任意URL
target=$(cd $(dirname $0) && pwd)

script=/tmp/GitHub.Uploader.Pi3.Https.201802210700/src/Uploader.py
python3 ${script} "${target}" -u  "${user}" -d "${desc}" -l "${url}"

