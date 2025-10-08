FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-cli \
    curl \
    mariadb-client \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /run/php
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/init_wordpress.sh /init_wordpress.sh
RUN chmod +x /init_wordpress.sh

CMD [ "/init_wordpress.sh" ]
