FROM debian:bullseye

RUN apt-get update && apt-get install -y     php7.4-fpm     php7.4-mysql     php7.4-curl     php7.4-gd     php7.4-intl     php7.4-mbstring     php7.4-soap     php7.4-xml     php7.4-xmlrpc     php7.4-zip     wget     curl     mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar     && chmod +x wp-cli.phar     && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/run/php

# Create WordPress directory with proper permissions
RUN mkdir -p /var/www/wordpress     && chown -R www-data:www-data /var/www/wordpress

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/wordpress_setup.sh /tmp/wordpress_setup.sh
RUN chmod +x /tmp/wordpress_setup.sh

EXPOSE 9000

ENTRYPOINT ["bash", "/tmp/wordpress_setup.sh", "php-fpm7.4", "-F"]