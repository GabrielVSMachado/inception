FROM alpine:3.16

ARG MARIADB_ROOT_PASSWORD
ARG MARIADB_USER_PASSWORD
ARG MARIADB_USER

COPY --chown=root:root entrypoint.sh /usr/bin/

RUN apk update; \
    apk add mysql=10.6.12-r0 mysql-client=10.6.12-r0; \
    ln -sf /usr/share/mariadb/mysql.server /usr/bin/mariadb-server; \
    sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf; \
    chmod +x /usr/bin/entrypoint.sh

EXPOSE 3306

VOLUME /var/lib/mysql

ENTRYPOINT ["entrypoint.sh"]
