#!/bin/bash


if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "WORDPRESS ALREADY CONFIGURED."
else
    echo "Downloading WordPress..."
    cd /var/www/wordpress
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url=${WP_URL} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    
    echo "Creating new user..."
    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${WP_USER_PASS} \
        --allow-root

fi

echo "Starting php-fpm..."
exec "$@"