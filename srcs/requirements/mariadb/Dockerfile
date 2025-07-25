FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y mariadb-server 

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/mariadb_script.sh /tmp/mariadb_script.sh

RUN chmod +x /tmp/mariadb_script.sh

ENTRYPOINT ["/tmp/mariadb_script.sh"]

CMD ["mysqld_safe", "--user=mysql"]



