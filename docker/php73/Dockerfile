FROM php:7.3-apache
RUN apt-get update \
    # libicu-dev → 下記intlインストールするのに必要っぽい
    # zip,libzip-dev → composer installするときに必要ってエラー出たので必要っぽい
    # libxml2-dev → たぶん必要？
    # git → npm installするときに必要？
    && apt-get install -y git libicu-dev zip libzip-dev libxml2-dev \
    && docker-php-ext-configure zip --with-libzip \
    # fileinfo → intervention/imageで必須
    && docker-php-ext-install pdo_mysql mysqli mbstring fileinfo intl zip xml

# composer2インストール
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN /usr/bin/composer self-update --2

# nodejs,npmインストール
# https://tsyama.hatenablog.com/entry/docker-not-found-npm
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs
RUN npm install npm@latest -g

# mod_rewrite有効化
RUN a2enmod rewrite

# alias作成
RUN { \
        echo "alias ll='ls -l --color=auto'"; \
    } >> /root/.bashrc

# コンテナ内に初回セットアップスクリプトをコピー
COPY init-script.sh /tmp/

WORKDIR /usr/local/militheta-gasha-simu/cake_app