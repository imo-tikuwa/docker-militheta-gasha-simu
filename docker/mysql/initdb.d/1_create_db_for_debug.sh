#!/bin/bash -eu

mysql=( mysql --protocol=socket -u root -p"${MYSQL_ROOT_PASSWORD}" )

"${mysql[@]}" <<-EOSQL
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}_debug;
    GRANT ALL ON ${MYSQL_DATABASE}_debug.* TO '$MYSQL_USER'@'%';
EOSQL