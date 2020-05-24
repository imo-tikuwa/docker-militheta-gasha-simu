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

# mod_rewrite有効化
RUN a2enmod rewrite

# アプリケーションのセットアップ(composer、npm)
# WORKDIR /usr/local/militheta-gasha-simu/cake_app
# RUN composer install --no-dev --no-interaction
# RUN bin/cake plugin unload Cake3AdminBaker
# RUN npm install
# RUN npm run build