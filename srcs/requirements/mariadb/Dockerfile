FROM alpine:3.16


RUN apk update; \
    apk add mysql=10.6.12-r0 mysql-client=10.6.12-r0; \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql; \
    ln -sf /usr/share/mariadb/mysql.server /usr/bin/mariadb-server; \
    sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf


EXPOSE 3306

COPY --chown=root:root mariadb_entrypoint.sh /usr/bin/mariadb_entrypoint.sh
RUN chmod +x /usr/bin/mariadb_entrypoint.sh

HEALTHCHECK --interval=15s --retries=3 \
CMD mariadb-admin -u root --password=$MARIADB_ROOT_PASSWORD ping -h localhost

ENTRYPOINT ["mariadb_entrypoint.sh"]
