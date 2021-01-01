FROM php:7.4-fpm

# The following line is to enable PHP7.4, PLEASE NOTE IT IS ONLY FOR THE FUCKING PHP 7.4
ENV PHP_EXTRA_CONFIGURE_ARGS="--with-apxs2 --disable-cgi --with-zip"

# Arguments defined in docker-compose.yml
# ARG user
# ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    npm \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql gd zip

# install mongodb ext
# RUN pecl install mongodb \
    # && docker-php-ext-enable mongodb \
    # && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongo.ini

# Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

# USER $user