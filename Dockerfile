FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 && \
    rm -rf /var/lib/apt/lists/*

# Create working directory and add low-quality script
RUN mkdir -p /var/www/html && \
    echo 'Hello, docker' > /var/www/html/index.html && \
    echo '#!/bin/bash\n\n# Useless script for testing\nx=1\ny=2\nif [ $x -eq $y ]; then echo "equal"; fi\nexit 0' > /var/www/html/bad_script.sh && \
    chmod +x /var/www/html/bad_script.sh && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
