FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache
RUN apt update && \
    apt install -y apache2 && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy demo website content
COPY index.html /var/www/html/index.html

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
