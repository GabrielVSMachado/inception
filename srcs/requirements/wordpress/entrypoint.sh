#!/bin/sh

WORDPRESS_LINK="https://br.wordpress.org/latest-pt_BR.tar.gz"
WORDPRESS_TAR_DIR="/www"
WORDPRESS_TAR_FILE="$WORDPRESS_TAR_DIR/latest-pt_BR.tar.gz"


wget -P $WORDPRESS_TAR_DIR $WORDPRESS_LINK

tar -C $WORDPRESS_TAR_DIR -xf $WORDPRESS_TAR_FILE

rm $WORDPRESS_TAR_FILE

PHP_PATH_CONFIG_FILE=/etc/php8/php-fpm.d/www.conf

PHP_FPM_USER="www"
PHP_FPM_GROUP="www"

exec php-fpm8 --nodaemonize
