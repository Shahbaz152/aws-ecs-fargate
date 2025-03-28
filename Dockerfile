FROM almalinux:8
LABEL Name="Shahbaz"
LABEL Emailid="alam.ggmail.com"
RUN yum install -y httpd \
        zip \
        unzip
WORKDIR /var/www/html
ADD https://www.free-css.com/assets/files/free-css-templates/download/page283/bloscot.zip /var/www/html
RUN unzip bloscot.zip
RUN cp -rvf  html/* .
EXPOSE 80
CMD ["apachectl", "-DFOREGROUND"]
