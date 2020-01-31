FROM ubuntu:bionic

LABEL maintainer="ppuppim@gmail.com"
LABEL description="Apache 2.4 / PHP 7.2"

RUN apt-get update 

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y \
apache2 \
curl \
vim \
php7.2 \
libapache2-mod-php7.2 \
php7.2-bcmath \
php7.2-gd \
php7.2-json \
php7.2-sqlite \
php7.2-mysql \
php7.2-curl \
php7.2-xml \
php7.2-mbstring \
php7.2-zip \
mcrypt \
php7.2-interbase \
php7.2-soap

RUN curl -sS https://getcomposer.org/installer | php -- --version=1.8.4 --install-dir=/usr/local/bin --filename=composer

#RUN chgrp -R www-data /var/www
#RUN find /var/www -type d -exec chmod 775 {} +
#RUN find /var/www -type f -exec chmod 664 {} +

RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /etc/php/7.2/apache2/php.ini
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN a2enmod rewrite

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]