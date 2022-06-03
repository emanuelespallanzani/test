FROM php:7.4.28-apache-buster
# FROM php:7.4.28-apache-bullseye
# FROM php:7.4.9-apache-buster
# FROM php:5.6.38-apache
# FROM php:7.4-apache

COPY --chown=www-data:www-data . /var/www/html
COPY ./virtualhost.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update \
    && apt-get install -y sudo git zip unzip nano

RUN docker-php-ext-configure calendar \
    && docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN composer install

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -

RUN apt-get install nodejs

RUN a2enmod rewrite
RUN /etc/init.d/apache2 restart

EXPOSE 80
