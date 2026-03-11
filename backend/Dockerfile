FROM php:8.5-cli

WORKDIR /app

RUN apt-get update && apt-get install -y libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN touch database/database.sqlite \
    && chmod -R 777 storage bootstrap/cache database

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
