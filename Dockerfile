FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache, set up working directory, write index.html, fix permissions, and clean cache
RUN apt-get update && \
    apt-get install -y apache2 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/html && \
    echo 'Hello, docker' > /var/www/html/index.html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set working directory
WORKDIR /var/www/html

# Expose Apache port
EXPOSE 80

# Run Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
