#!/bin/bash

while ! mysqladmin ping -h mariadb ; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if [ -f /var/www/html/wp-config.php ]; then
    echo "wordpress already here "
else
    cd /var/www/html
    wp core download --allow-root

    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost="mariadb:3306" \
        --allow-root

    wp core install \
        --url=${WP_URL} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${WP_USER_PASS} \
        --allow-root
    
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6000 --allow-root
    wp config set WP_CACHE true --allow-root --raw
    
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

exec php-fpm7.4 -F