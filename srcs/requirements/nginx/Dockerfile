FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup-nginx.sh /usr/local/bin/setup-nginx.sh

RUN chmod +x /usr/local/bin/setup-nginx.sh

EXPOSE 443

CMD ["setup-nginx.sh"]
