#!/bin/sh

cd /usr/local/militheta-gasha-simu/cake_app

# create .env
if [ -f "/usr/local/militheta-gasha-simu/cake_app/config/.env" ]; then
    rm -f /usr/local/militheta-gasha-simu/cake_app/config/.env
fi
cat << EOF > /usr/local/militheta-gasha-simu/cake_app/config/.env
#!/usr/bin/env bash

# CakePHPの標準の設定
export APP_NAME="MillithetaGashaSimu"
export DEBUG="false"
export APP_ENCODING="UTF-8"
export APP_DEFAULT_LOCALE="ja_JP"
export APP_DEFAULT_TIMEZONE="Asia/Tokyo"
export SECURITY_SALT="jHRuXqo8amappyTo5GjUFws6iPCX4hGyVZ5zsjdPHWOk3WY9gTjgOwpzZoJYoRES"

# CakePHPのデータベース設定
export DATABASE_HOST="mysql"
export DATABASE_NAME="$MYSQL_DATABASE"
export DATABASE_PORT="3306"
export DATABASE_USER="$MYSQL_USER"
export DATABASE_PASS="$MYSQL_PASSWORD"

# その他
# GoogleMapAPIキー
export GOOGLEMAP_API_KEY=""
EOF

# composer install.
if [ -d "/usr/local/militheta-gasha-simu/cake_app/vendor" ]; then
    rm -fR /usr/local/militheta-gasha-simu/cake_app/vendor/*
fi
composer install --no-dev --no-interaction

# npm install(and build).
if [ -d "/usr/local/militheta-gasha-simu/cake_app/node_modules" ]; then
    rm -fR /usr/local/militheta-gasha-simu/cake_app/node_modules/*
fi
# /usr/local/militheta-gasha-simu/cake_appでnpm install実行すると以下のようなエラーが出て落ちる
# npm ERR! Error while executing:
# npm ERR! /usr/bin/git ls-remote -h -t https://github.com/imo-tikuwa/select2-bootstrap4-theme.git
# npm ERR!
# npm ERR! fatal: not a git repository: /usr/local/militheta-gasha-simu/../.git/modules/militheta-gasha-simu
# 調べるとサブモジュールが原因？？っぽい情報があるけどnpm installの失敗とどう関わってるのかが不明
# とりあえずpackage.jsonとpackage-lock.jsonを/tmpにコピー
# /tmpでnpm installしてダウンロードしたnode_modulesのモジュールを/usr/local/militheta-gasha-simu/cake_app以下に移動
# その他npm run devしようとしたところcross-env,webpackが参照できないっぽいエラーが出たのでcross-envとwebpackについてパスを指定して実行
cp package* /tmp/
cd /tmp
npm install
mv node_modules/* /usr/local/militheta-gasha-simu/cake_app/node_modules/
cd /usr/local/militheta-gasha-simu/cake_app
node node_modules/cross-env/src/bin/cross-env.js NODE_ENV=development node_modules/webpack/bin/webpack.js --progress

# execute CakePHP setup commands.
bin/cake execute_all_migrations_and_seeds
if [ -d "/usr/local/militheta-gasha-simu/cake_app/vendor/imo-tikuwa/cakephp-operation-logs" ]; then
    bin/cake init_operation_logs
fi
bin/cake cache clear_all
if [ -d "/usr/local/militheta-gasha-simu/cake_app/vendor/imo-tikuwa/cakephp-zipcode-jp" ]; then
    bin/cake initialize_zipcode_jp
fi
bin/cake cache clear_all
bin/cake recreate_admin admin@imo-tikuwa.com password
