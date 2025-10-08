FROM debian:bullseye


RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /run/mysqld
RUN chown mysql:mysql /run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init_db.sh /init_db.sh

RUN chmod +x /init_db.sh

CMD ["/init_db.sh"]



