FROM public.ecr.aws/lts/ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 sudo curl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/html && \
    echo 'Hello, docker' > /var/www/html/index.html && \
    chmod 777 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

EXPOSE 80

CMD ["/entrypoint.sh"]
