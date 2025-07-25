#!/bin/bash

# This script ensures MariaDB is initialized only once.

# Check if the database directory already exists. If so, we skip initialization.
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "MariaDB database not found. Initializing..."

    # Start MariaDB in a temporary background process.
    mysqld_safe --user=mysql &

    # Wait for the MariaDB server to be ready for connections.
    until mysqladmin ping -hlocalhost --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 1
    done

    # Execute SQL commands to set up the database, users, and root password.
    # On a fresh install, root has no password, so we connect without one.
    mysql -u root <<-EOF
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOF

    # Shut down the temporary MariaDB instance using the new root password.
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

echo "Initialization complete. Starting MariaDB in foreground..."
# Execute the CMD from the Dockerfile (e.g., "mysqld") to start the main server process.
exec "$@"
