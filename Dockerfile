FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache, unzip, and curl
RUN apt update && \
    apt install -y apache2 unzip curl && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Download and unzip the template
RUN curl -L -o bloscot.zip https://www.free-css.com/assets/files/free-css-templates/download/page283/bloscot.zip && \
    unzip bloscot.zip && \
    cp -rvf html/* . && \
    rm -rf html bloscot.zip

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose Apache port
EXPOSE 80

# Run Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
