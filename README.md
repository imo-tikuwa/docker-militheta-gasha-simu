# docker-militheta-gasha-simu

## このリポジトリについて
[militheta-gasha-simu](https://github.com/imo-tikuwa/militheta-gasha-simu)の環境構築をdockerを使って行うことを目的とした勉強用リポジトリです

## インストール
サブモジュールのリポジトリより初期データのSQLをコピーしてからビルドする
```
cp militheta-gasha-simu/env/create_millitheta.sql docker/mysql/initdb.d/01_create_millitheta.sql
cp militheta-gasha-simu/env/millitheta.sql docker/mysql/initdb.d/02_millitheta.sql

docker-compose build --no-cache
docker-compose up -d
```

---
DBの確認
```
docker-compose exec mysql bash
mysql -u root -proot

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| millitheta         |
| millitheta_debug   |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

---
アプリケーションの設定と確認  
※npm installでno such云々のエラーが出る
```
docker-compose exec php bash

cd /usr/local/militheta-gasha-simu/cake_app
composer install --no-dev --no-interaction
bin/cake plugin unload Cake3AdminBaker
npm install
npm run build
```

## メモ（備忘録）
gitリポジトリの中にリポジトリを含める（サブモジュール）
```
git submodule add https://github.com/imo-tikuwa/militheta-gasha-simu.git
```

---
サブモジュールの変更について親リポジトリの差分ファイルに出さないようにする？
```
git config --file=.gitmodules submodule.militheta-gasha-simu.ignore dirty
```

---
全て最初からやり直すためにいったん全部消す
```
docker-compose down --rmi all --volumes
```
