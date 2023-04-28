#!/bin/sh

set -e

if [[ $1 == "entrypoint" ]]; then
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

elif [[ $1 == "health_check" ]]; then

mariadb-admin \
  -u root \
  --password=$MARIADB_ROOT_PASSWORD \
  ping -h localhost

else

echo "Wrong Argument!!!"
exit 1

fi
