#!/bin/sh

set -e

entrypoint() {

mariadb-install-db --user=mysql --datadir=/var/lib/mysql

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
  -e "CREATE USER IF NOT EXISTS 'gvitor-s'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD'; \
      GRANT ALL PRIVILEGES ON *.* TO 'gvitor-s'@'%'; FLUSH PRIVILEGES"

mariadb \
  -u root \
  -e "FLUSH PRIVILEGES; \
      ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD'"

mariadb-server stop

}

export DATABASE_ALREADY_EXISTS="false"

[ $(ls /var/lib/mysql | wc -l) -gt 0 ] && export DATABASE_ALREADY_EXISTS="true"


[ "$DATABASE_ALREADY_EXISTS" != "true" ] && entrypoint

echo "Mariadb ready to start !!!"

exec mariadbd --user=mysql
