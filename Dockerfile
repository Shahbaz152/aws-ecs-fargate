FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache without cache and insecure chmod
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 curl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/html && \
    echo 'Hello, docker' > /var/www/html/index.html && \
    chmod 777 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Copy vulnerable script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

EXPOSE 80

# Use insecure script as entrypoint
CMD ["/entrypoint.sh"]
