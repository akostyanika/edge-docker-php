FROM alpine:3.7

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/launch.sh"]

RUN apk add --no-cache \
        bash \
        bash-completion \
        ca-certificates \
        curl \
        findutils \
        git \
        git-bash-completion \
        msmtp \
        nano \
        openssh \
        openssh-sftp-server \
        patch \
        py2-pip \
        sudo \
        supervisor \
        shadow \
        tar \
        unzip \
        wget

ENV PHP_VERSION=7.1 \
    ENABLE_CRON=Off \
    ENABLE_SSH=Off \
    ENABLE_DEV=Off \
    NGINX_CONF=default \
    NGINX_PORT=80 \
    PHP_DISPLAY_ERRORS=Off \
    PHP_OPCACHE_VALIDATE=On \
    PHP_MAX_CHILDREN=20 \
    PHP_TIMEZONE=Europe/London \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    WEB_ROOT=/var/www \
    XDEBUG_ENABLE=Off \
    XDEBUG_HOST= \
    SMTP_HOST=smtp.mailtrap.io \
    SMTP_PORT=25 \
    SMTP_USER= \
    SMTP_PASS= \
    SMTP_FROM=

RUN apk add --no-cache \
        php7=~${PHP_VERSION} \
            php7-bcmath \
            php7-ctype \
            php7-curl \
            php7-dom \
            php7-fileinfo \
            php7-fpm \
            php7-iconv \
            php7-intl \
            php7-json \
            php7-mbstring \
            php7-mcrypt \
            php7-mysqli \
            php7-mysqlnd \
            php7-opcache \
            php7-openssl \
            php7-phar \
            php7-pdo_mysql \
            php7-redis \
            php7-xdebug \
            php7-simplexml \
            php7-soap \
            php7-tokenizer \
            php7-xml \
            php7-xmlreader \
            php7-xmlwriter \
            php7-xsl \
            php7-zip \
        nginx \
        nodejs \
        nodejs-npm && \
    npm install gulp-cli -g && \
    npm cache clean --force && \
    rm -Rf /var/www/*

COPY . /

RUN /build.sh

USER edge

EXPOSE $NGINX_PORT