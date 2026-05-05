#!/bin/bash

echo " Iniciando Comadreja Shop..."

# Red
docker network inspect comadreja_net >/dev/null 2>&1 || docker network create comadreja_net

# Volumen
docker volume inspect comadreja_db_data >/dev/null 2>&1 || docker volume create comadreja_db_data

# MySQL
docker rm -f comadreja_db >/dev/null 2>&1

docker run -d \
  --name comadreja_db \
  --network comadreja_net \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=comadreja \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=password \
  -v comadreja_db_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql:8

echo " Esperando MySQL..."
sleep 15

# Build app
docker build -t comadreja_app .

# Run app
docker rm -f comadreja_app >/dev/null 2>&1

docker run -d \
  --name comadreja_app \
  --network comadreja_net \
  -p 8000:80 \
  comadreja_app

echo " Instalando Laravel..."

# Instalar Laravel
docker exec comadreja_app bash -c "rm -rf /var/www/html/*"
docker exec comadreja_app bash -c "composer create-project laravel/laravel:^12.0 ."

# Configurar entorno
docker exec comadreja_app bash -c "cp .env.example .env"

docker exec comadreja_app bash -c "sed -i 's/DB_HOST=.*/DB_HOST=comadreja_db/' .env"
docker exec comadreja_app bash -c "sed -i 's/DB_DATABASE=.*/DB_DATABASE=comadreja/' .env"
docker exec comadreja_app bash -c "sed -i 's/DB_USERNAME=.*/DB_USERNAME=user/' .env"
docker exec comadreja_app bash -c "sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/' .env"

#  CLAVE: permisos correctos
docker exec comadreja_app bash -c "chown -R www-data:www-data /var/www/html"
docker exec comadreja_app bash -c "chmod -R 775 storage bootstrap/cache"

# Laravel setup
docker exec comadreja_app bash -c "php artisan key:generate"
docker exec comadreja_app bash -c "php artisan config:clear"
docker exec comadreja_app bash -c "php artisan cache:clear"

# Migraciones
docker exec comadreja_app bash -c "php artisan migrate --force"

# Filament
echo "⏳ Instalando Filament..."

docker exec comadreja_app bash -c "composer require filament/filament"
docker exec comadreja_app bash -c "php artisan filament:install --panels"
docker exec comadreja_app bash -c "php artisan filament:assets"

echo " Todo listo"
echo " http://localhost:8000"
echo " http://localhost:8000/admin"