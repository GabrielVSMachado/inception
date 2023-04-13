FROM alpine:3.16

ENV WORDPRESS_LINK="https://br.wordpress.org/latest-pt_BR.tar.gz"
ENV WORDPRESS_TAR_PATH="/usr/share/webapps"


RUN apk update; \
    apk add php8-fpm php8-soap php8-openssl \
    php8-gmp php8-pdo_odbc php8-json php8-dom php8-pdo php8-zip \
    php8-mysqli php8-sqlite3 php8-apcu php8-pdo_pgsql php8-bcmath php8-gd php8-odbc \
    php8-pdo_mysql php8-pdo_sqlite php8-gettext php8-xmlreader php8-bz2 php8-iconv \
    php8-pdo_dblib php8-curl php8-ctype wget; \
    wget -P ${WORDPRESS_TAR_PATH} ${WORDPRESS_LINK}; \
    tar -C ${WORDPRESS_TAR_PATH} -xf ${WORDPRESS_TAR_PATH}; \
    rm ${WORDPRESS_TAR_PATH}/*.gz; \
    sed -i 's/listen = .*/listen = 0.0.0.0:9000/g' /etc/php8/php-fpm.d/www.conf


CMD ["php-fpm8", "-F"]
