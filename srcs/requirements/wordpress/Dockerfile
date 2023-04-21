FROM alpine:3.16

RUN apk update; \
    apk add php8-fpm php8-soap php8-openssl \
    php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip \
    php8-mysqli php8-sqlite3 php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc \
    php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv \
    php8-pdo_dblib php8-curl php8-ctype wget; \
    adduser -D www -g www

# criar entrypoint sh porque os arquivos do wordpress não estão permanecendo no container

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

CMD ["tail", "-f"]
