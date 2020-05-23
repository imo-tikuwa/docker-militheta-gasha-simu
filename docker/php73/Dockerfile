FROM php:7.3-apache
RUN apt-get update \
    # libicu-dev → 下記intlインストールするのに必要っぽい
    # zip,libzip-dev → composer installするときに必要ってエラー出たので必要っぽい
    # libxml2-dev → たぶん必要？
    # git → npm installするときに必要？
    && apt-get install -y git libicu-dev zip libzip-dev libxml2-dev \
    && docker-php-ext-configure zip --with-libzip \
    # intl → cakephp3で必須
    # fileinfo → intervention/imageで必須
    && docker-php-ext-install pdo_mysql mysqli mbstring fileinfo intl zip xml

# composerインストール
# https://qiita.com/yatsubashi/items/02bbbebbfe7e5a5976bc
COPY --from=composer /usr/bin/composer /usr/bin/composer

# nodejs,npmインストール
# https://tsyama.hatenablog.com/entry/docker-not-found-npm
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
# RUN npm install npm@latest -g

# apacheのドキュメントルート変更
# https://stackoverflow.com/questions/51393494/how-to-change-the-document-root-in-php7-1-apache-from-docker-compose-yml
# ローカル側(docker/php73)に000-default.confを用意して/etc/apache2/sites-availableにマウントする形でも良いかもしれない？
ENV APACHE_DOCUMENT_ROOT=/usr/local/militheta-gasha-simu/cake_app/webroot
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
