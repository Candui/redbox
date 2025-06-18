FROM php:8.1-fpm

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    zip \
    git \
    curl \
    build-essential \
    && docker-php-ext-install pdo pdo_pgsql

# Установка Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Установка Redis из локального архива
COPY redis-6.0.2.tgz /tmp/redis.tgz
RUN cd /tmp \
    && tar -xzf redis.tgz \
    && cd redis-6.0.2 \
    && phpize \
    && ./configure \
    && make && make install \
    && docker-php-ext-enable redis \
    && cd /tmp && rm -rf redis-6.0.2 redis.tgz

# Рабочая директория
WORKDIR /var/www/html

# Копируем проект и зависимости
COPY . .

# Установка зависимостей Composer
RUN [ -f composer.json ] && composer install || echo "No composer.json found"
