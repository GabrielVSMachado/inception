FROM alpine:3.16

ARG PHP_PATH_CONFIG_FILE=/etc/php8/php-fpm.d/www.conf
ARG LOG_ACCESS="access.log = /proc/self/fd/2;"
ARG LOG_ERROR="error_log = /proc/self/fd/2;"

RUN apk update; \
    apk add php8-fpm php8-soap php8-openssl \
    php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip \
    php8-mysqli php8-sqlite3 php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc \
    php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv \
    php8-pdo_dblib php8-curl php8-ctype wget; \
    adduser -D www -g www; \
    mkdir -p -m 775 /www; \
    chown -R www:www /www; \
    chown -R www:www /var/log/php8; \
    sed -i 's|listen = .*|listen = 0.0.0.0:9000|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i 's|user\s*=\s*nobody|;user = nobody|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i 's|group\s*=\s*nobody|;group = nobody|g' ${PHP_PATH_CONFIG_FILE}; \
    sed -i "5i ${LOG_ACCESS}\n\n\[global\]\n${LOG_ERROR}\n\n\[www\]" \
    ${PHP_PATH_CONFIG_FILE}


COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /www

USER www

ENTRYPOINT ["entrypoint.sh"]
