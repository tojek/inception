#!/bin/bash

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating SSL certificate..."
    mkdir -p /etc/nginx/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=PL/ST=Warsaw/L=Warsaw/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

echo "Substituting environment variables in nginx config..."
sed -i "s|\${DOMAIN_NAME}|${DOMAIN_NAME}|g" /etc/nginx/nginx.conf

echo "Starting Nginx..."
exec nginx -g "daemon off;"
