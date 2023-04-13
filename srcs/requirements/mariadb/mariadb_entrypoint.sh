#!/bin/sh

set -e

#rise service
mariadb-server start

CHARACTERS='a-zA-Z0-9"!@#$%&*()-_=+[],.?^`{}'

mariadb-secure-installation <<EOF
  $MARIADB_ROOT_PASSWORD
  Y
  n
  Y
  Y
  Y
  Y
EOF


mariadb \
  -u root \
  -e "CREATE USER 'gvitor-s'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD'"

mariadb \
  -u root \
  -e "GRANT ALL PRIVILEGES ON *.* TO 'gvitor-s'@'%'; FLUSH PRIVILEGES"

mariadb \
  -u root \
  -e "CREATE DATABASE wordpress;
      GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';
      FLUSH PRIVILEGES
    "

mariadb \
  -u root \
  -e "FLUSH PRIVILEGES; \
      ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD'"

kill -9 $(cat /var/lib/mysql/$HOSTNAME.pid)

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

exec mariadbd --user=mysql --bind-address=0.0.0.0
