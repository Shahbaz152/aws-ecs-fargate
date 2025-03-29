FROM ubuntu:20.04

ENV CONTAINER_TIMEZONE="Europe/Brussels"
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN apt update && apt install -y apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/www/html
WORKDIR /var/www/html
ADD https://www.free-css.com/assets/files/free-css-templates/download/page283/bloscot.zip /var/www/html
RUN unzip bloscot.zip
RUN cp -rvf  html/* .
EXPOSE 80
#RUN echo 'Hello, docker' > /var/www/index.html

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
