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
```
docker-compose exec php bash

cd /usr/local/militheta-gasha-simu/cake_app
composer install --no-dev --no-interaction
bin/cake plugin unload Cake3AdminBaker
bin/cake init_operation_logs
npm install
npm run build

cat << EOS > /usr/local/militheta-gasha-simu/cake_app/config/.env
#!/usr/bin/env bash

# CakePHP3の標準の設定
export APP_NAME="MillithetaGashaSimu"
export DEBUG="false"
export APP_ENCODING="UTF-8"
export APP_DEFAULT_LOCALE="ja_JP"
export APP_DEFAULT_TIMEZONE="Asia/Tokyo"
export SECURITY_SALT="7Tosv70DGOM0SGEJcyS6MjMWOWtsPKawUHc5CgjyxbiiQulIiQZfYCEdbcEY2r1A"

# CakePHP3のデータベース設定
export DATABASE_HOST="mysql"
export DATABASE_NAME="millitheta"
export DATABASE_PORT="3306"
export DATABASE_USER="millitheta"
export DATABASE_PASS="92xUCSRgoBqZ0qyB"
EOS
```

## メモ（備忘録）
全て最初からやり直すためにいったん全部消す
```
docker-compose down --rmi all --volumes
```
