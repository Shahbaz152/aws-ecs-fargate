FROM public.ecr.aws/lts/ubuntu:latest

# Install Apache
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 && \
    rm -rf /var/lib/apt/lists/*

# Add bad script to trigger SonarCloud issues
RUN mkdir -p /var/www/html && \
    echo 'Hello, docker' > /var/www/html/index.html && \
    echo "#!/bin/bash

# Bad Shell Script - Intentionally poor for SonarCloud analysis

do_something_bad() {
  var1=123
  var2=456
  var3=789
  echo \"Doing something with $var1\"
  echo \"Doing something with $var2\"
  echo \"Doing something with $var3\"

  # Duplicate logic
  echo \"Doing something with $var1\"
  echo \"Doing something with $var2\"
  echo \"Doing something with $var3\"

  # Unused variable
  unused_var=42

  for i in {1..50}; do
    echo \"Spam line \$i\" >> /dev/null
  done

  # Hardcoded credentials (bad practice)
  USERNAME='admin'
  PASSWORD='123456'
  echo \"Logging in as \$USERNAME with \$PASSWORD\"
}

do_something_bad
" > /var/www/html/bad_script.sh && \
    chmod +x /var/www/html/bad_script.sh && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

WORKDIR /var/www/html

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
