# docker-militheta-gasha-simu

## このリポジトリについて
[militheta-gasha-simu](https://github.com/imo-tikuwa/militheta-gasha-simu)の環境構築をdockerを使って行うことを目的とした勉強用リポジトリです

## インストール手順
当リポジトリをクローン
```
git clone https://github.com/imo-tikuwa/docker-militheta-gasha-simu.git
cd docker-militheta-gasha-simu
```

アプリケーション本体をクローン
```
git clone https://github.com/imo-tikuwa/militheta-gasha-simu.git
```

アプリケーション本体以下の初期データSQLをコピー
```
cp militheta-gasha-simu/env/create_millitheta.sql docker/mysql/initdb.d/01_create_millitheta.sql
cp militheta-gasha-simu/env/millitheta.sql docker/mysql/initdb.d/02_millitheta.sql
```

docker-compose.ymlに基づきphp(apache)、mysqlコンテナをビルド
```
docker-compose build --no-cache
docker-compose up -d
```

---
アプリケーションの設定と確認  
```
docker-compose exec php bash

cd /usr/local/militheta-gasha-simu/cake_app
composer install --no-dev --no-interaction
bin/cake plugin unload Cake3AdminBaker
bin/cake init_operation_logs
npm run build
```

---
DBの確認
```
docker-compose exec mysql bash
mysql -u millitheta -p92xUCSRgoBqZ0qyB

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| millitheta         |
| millitheta_debug   |
+--------------------+
```

## メモ（備忘録）
全て最初からやり直すためにいったん全部消す
```
docker-compose down --rmi all --volumes
```