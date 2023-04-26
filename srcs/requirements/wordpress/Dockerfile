FROM alpine:3.16

ARG PHP_PATH_CONFIG_FILE=/etc/php8/php-fpm.d/www.conf
ARG LOG_ACCESS="access.log = /proc/self/fd/2;"
ARG LOG_ERROR="error_log = /proc/self/fd/2;"
ARG WP_CLI="https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"

RUN apk update; \
    apk add php8-fpm php8-soap php8-openssl \
    php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip \
    php8-mysqli php8-sqlite3 php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc \
    php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv \
    php8-pdo_dblib php8-curl php8-ctype php8-phar wget mariadb-client; \
    adduser -D www -g www; \
    mkdir -p -m 775 /www; \
    chown -R www:www /www; \
    chown -R www:www /var/log/php8; \
    sed -i 's|listen = .*|listen = 0.0.0.0:9000|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i 's|user\s*=\s*nobody|user = www|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i 's|group\s*=\s*nobody|group = www|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i "5i ${LOG_ACCESS}\n\n" ${PHP_PATH_CONFIG_FILE}; \
    wget -P /usr/bin ${WP_CLI}; \
    mv /usr/bin/wp-cli.phar /usr/bin/wp; \
    chmod +x /usr/bin/wp; \
    apk del wget

WORKDIR /www

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]
