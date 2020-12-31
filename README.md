# docker-militheta-gasha-simu

## このリポジトリについて
[militheta-gasha-simu](https://github.com/imo-tikuwa/militheta-gasha-simu)の環境構築をdockerを使って行うことを目的とした勉強用リポジトリです

## インストール手順
リポジトリをクローン(サブモジュール含む)
```
git clone --recursive https://github.com/imo-tikuwa/docker-militheta-gasha-simu.git
cd docker-militheta-gasha-simu
```

docker-compose.ymlに基づきphp(apache)、mysqlコンテナをビルド
```
docker-compose build --no-cache
docker-compose up -d
```

アプリケーションの初回セットアップ  
```
docker-compose exec php /tmp/init-script.sh
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
