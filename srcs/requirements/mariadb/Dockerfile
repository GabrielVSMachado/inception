FROM alpine:3.16

ARG MARIADB_ROOT_PASSWORD
ARG MARIADB_USER_PASSWORD
ARG MARIADB_USER

RUN apk update; \
    apk add mysql=10.6.12-r0 mysql-client=10.6.12-r0; \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql; \
    ln -sf /usr/share/mariadb/mysql.server /usr/bin/mariadb-server; \
    sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf; \
    chown -R mysql /var/lib/mysql

COPY --chown=root:root setup.sh /usr/bin/

RUN chmod +x /usr/bin/setup.sh; \
    setup.sh "entrypoint"

HEALTHCHECK --interval=15s --retries=3 CMD setup.sh "health_check"

EXPOSE 3306

VOLUME /var/lib/mysql

USER mysql

ENTRYPOINT ["mariadbd", "--bind-address=0.0.0.0"]
