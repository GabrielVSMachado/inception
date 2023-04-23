#!/bin/sh

WORDPRESS_LINK="https://br.wordpress.org/latest-pt_BR.tar.gz"
WORDPRESS_TAR_DIR="/www"
WORDPRESS_TAR_FILE="$WORDPRESS_TAR_DIR/latest-pt_BR.tar.gz"


if [[ $(ls /www/wordpress | wc -l) -eq 0 ]]; then
  wget -P $WORDPRESS_TAR_DIR $WORDPRESS_LINK

  tar -C $WORDPRESS_TAR_DIR -xf $WORDPRESS_TAR_FILE

  rm $WORDPRESS_TAR_FILE
fi

exec php-fpm8 --nodaemonize
