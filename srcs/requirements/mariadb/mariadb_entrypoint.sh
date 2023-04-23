#!/bin/sh

set -e

#rise service
mariadb-server start

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
  -e "CREATE USER IF NOT EXISTS 'gvitor-s'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD'"

mariadb \
  -u root \
  -e "GRANT ALL PRIVILEGES ON *.* TO 'gvitor-s'@'%'; FLUSH PRIVILEGES"

mariadb \
  -u root \
  -e "CREATE DATABASE IF NOT EXISTS wordpress;
      GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'password';
      FLUSH PRIVILEGES
    "

mariadb \
  -u root \
  -e "FLUSH PRIVILEGES; \
      ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD'"

mariadb-server stop

while [[ $(mariadb-server status | awk '{print $1}') != 'ERROR!' ]]; do
  echo "Waiting..."
done
echo "Done!"

exec mariadbd --user=mysql --bind-address=0.0.0.0
