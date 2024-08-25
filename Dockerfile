# Gunakan image PHP yang sudah dilengkapi dengan Apache
FROM php:7.4-apache

# Instal dependensi dan ekstensi PHP yang dibutuhkan
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip

# Aktifkan mod_rewrite
RUN a2enmod rewrite

# Instal ekstensi MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Salin konfigurasi Apache
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Atur direktori kerja
WORKDIR /var/www/html

# Salin file CodeIgniter ke dalam kontainer
COPY . /var/www/html

# Ubah kepemilikan folder ke user www-data
RUN chown -R www-data:www-data /var/www/html

# Ekspose port 80
EXPOSE 80
