#!/bin/sh


WORDPRESS_LINK="https://br.wordpress.org/latest-pt_BR.tar.gz"
WORDPRESS_TAR_DIR="/usr/share/webapps"
WORDPRESS_TAR_FILE="$WORDPRESS_TAR_DIR/latest-pt_BR.tar.gz"


wget -P $WORDPRESS_TAR_DIR $WORDPRESS_LINK

tar -C $WORDPRESS_TAR_DIR -xf $WORDPRESS_TAR_FILE

rm $WORDPRESS_TAR_FILE

sed -i 's/listen = .*/listen = 0.0.0.0:9000/g' /etc/php8/php-fpm.d/www.conf

sed -i 's/user = nobody/user = www/g' /etc/php8/php-fpm.d/www.conf
sed -i 's/group = nobody/group = www/g' /etc/php8/php-fpm.d/www.conf

chmod -R g+w /usr/share/webapps/wordpress
chown -R :http /usr/share/webapps/wordpress
