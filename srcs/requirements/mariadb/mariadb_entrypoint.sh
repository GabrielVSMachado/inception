#!/bin/sh

set -e

#rise service
mariadb-server start

CHARACTERS='a-zA-Z0-9"!@#$%&*()-_=+[],.?^`{}'

MARIADB_RANDOM_PASSWORD=$(tr -dc $CHARACTERS </dev/urandom | head -c 80)

mariadb-secure-installation <<EOF
  $MARIADB_RANDOM_PASSWORD
  Y
  n
  Y
  Y
  Y
  Y
EOF


mariadb \
  -u root \
  -e "CREATE USER 'gvitor-s'@'localhost' IDENTIFIED BY '$MARIADB_USER_PASSWORD'"

mariadb \
  -u root \
  -e "GRANT ALL PRIVILEGES ON mysql.* TO 'gvitor-s'@'localhost'; FLUSH PRIVILEGES"

mariadb \
  -u root \
  -e "FLUSH PRIVILEGES; \
      ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_RANDOM_PASSWORD'"

kill -9 $(cat /var/lib/mysql/$HOSTNAME.pid)

exec mariadbd --user=mysql
