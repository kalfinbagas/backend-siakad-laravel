FROM php:8.0-apache
WORKDIR /var/www/html
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libzip-dev


RUN docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY composer.json composer.lock ./
RUN composer install --no-scripts --no-autoloader
COPY . .
RUN composer dump-autoload
RUN chown -R www-data:www-data storage bootstrap/cache
EXPOSE 8000
CMD ["php-fpm"]