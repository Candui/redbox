FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && pecl install redis \
    && docker-php-ext-enable redis

WORKDIR /var/www/html
