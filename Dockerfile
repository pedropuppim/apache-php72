FROM ubuntu:bionic

LABEL maintainer="ppuppim@gmail.com"
LABEL description="Apache 2.4 / PHP 7.2"

# Set working directory
WORKDIR /var/www/html

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
php7.2-soap \
php7.2-memcache \
php7.2-intl \
php7.2-redis \ 
php7.2-tidy

RUN curl -sS https://getcomposer.org/installer | php -- --version=2.3.5 --install-dir=/usr/local/bin --filename=composer


RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/^max_input_vars\s*=.*/max_input_vars = 5000/' /etc/php/7.2/apache2/php.ini
RUN sed -i -e 's/^post_max_size\s*=.*/post_max_size = 250/' /etc/php/7.2/apache2/php.ini

RUN sed -i -e 's/^zlib.output_compression\s*=.*/zlib.output_compression = Off/' /etc/php/7.2/apache2/php.ini
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN a2enmod rewrite

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
