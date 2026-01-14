#!/bin/bash

# Read secrets
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Ensure required directories exist
mkdir -p /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Starting MariaDB temporarily..."
    mysqld --user=mysql --datadir=/var/lib/mysql &
    pid="$!"

    echo "Waiting for MariaDB to start..."
    for i in {30..0}; do
        if mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; then
            break
        fi
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo "ERROR: MariaDB failed to start"
        exit 1
    fi

    echo "Setting up database and users..."
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    echo "Shutting down temporary MariaDB..."
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    wait "$pid"
fi

echo "Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql
