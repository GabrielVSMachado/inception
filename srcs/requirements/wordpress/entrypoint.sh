#!/bin/sh

WORDPRESS_DIR_PATH=wordpress
WORDPRESS_CONFIG_PATH="$WORDPRESS_DIR_PATH/wp-config.php"


if [[ $(ls /www/wordpress | wc -l) -eq 0 ]]; then
  wp core download --path=$WORDPRESS_DIR_PATH

  wp config create \
    --dbname=wordpress \
    --dbuser=$MARIADB_USER \
    --dbpass=$MARIADB_USER_PASSWORD \
    --dbhost=db \
    --path=$WORDPRESS_DIR_PATH

  wp db create --path=$WORDPRESS_DIR_PATH

  wp core install \
    --url=localhost \
    --title="42sp-inception" \
    --admin_user=$MARIADB_USER \
    --admin_password=$MARIADB_USER_PASSWORD \
    --admin_email="$MARIADB_USER@student.42sp.org.br" \
    --path=$WORDPRESS_DIR_PATH

  sed -i '21i define("WP_HOME", "https://" . $_SERVER["HTTP_HOST"]. "/");\n' \
    $WORDPRESS_CONFIG_PATH
  sed -i '22i define("WP_SITEURL", "https://" .$_SERVER["HTTP_HOST"]. "/");\n' \
    $WORDPRESS_CONFIG_PATH
fi

exec php-fpm8 --nodaemonize
