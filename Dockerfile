#   Objectives:
    ##  1. Install Apache and php 5.6
    ##  2. Install Component and php extensions
    ##  3. Install Composer


##  1. Install Apache and php 5.6
# This Docker Image instantiate from phusion/baseimage:0.10.0 Image
# phusion/baseimage:0.10.0 is a light version of Ubuntu 16.04 with PHP 5.6 installed
FROM alexcheng/apache2-php5:5.6.33

##  2. Install Component and php extensions
RUN apt-get update && \
# PHP Extension
    apt-get install -y mysql-client-5.7 libxml2-dev libmcrypt4 libmcrypt-dev libpng-dev libjpeg-dev libfreetype6 libfreetype6-dev && \
# Install Soap PDO Mcrypt
    docker-php-ext-install soap pdo_mysql mcrypt mysqli && \
# Configure GD
    docker-php-ext-configure gd --with-jpeg-dir=/usr/lib/ --with-freetype-dir=/usr/lib/ && \
# Install gd
    docker-php-ext-install gd && \
# Install php-zip
    docker-php-ext-install zip && \
# a2enmod rewrite
    a2enmod rewrite && \
# Install Tools
    apt-get update && \
    apt-get install -y \
    nano \
    vim \
    telnet \
    netcat \
    git-core \
    zip && \
    apt-get purge -y --auto-remove && \ 
    rm -rf /var/lib/apt/lists/*
RUN apt update
# Install Nmap
RUN apt install -y nmap && \
# Install SSHD KEY
    /usr/bin/ssh-keygen -A && \
# Update and Remove
    apt-get update -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \ 
    rm -rf /var/lib/apt/lists/* && \
##  3. Install 'Composer'
    curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
##  Install Magerun/n98-magerun
COPY files/magerun /usr/local/bin/magerun
##  Install Modman
COPY files/modman /usr/local/bin/modman
COPY entrypoint.sh  /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
WORKDIR /var/www


## Docker image name:                           apache-php-5.6-magento-environment
## Docker Hub Image Name:                       devtutspace/apache-php-5.6-magento-environment
## Docker Image Build command:                  docker build -t apache-php-5.6-magento-environment ./
## Docker Image Build No Cache command:         docker build --no-cache -t apache-php-5.6-magento-environment ./
## Docker Image Tag command:                    docker tag apache-php-5.6-magento-environment devtutspace/apache-php-5.6-magento-environment
## Docker Image Push command:                   docker push devtutspace/apache-php-5.6-magento-environment
## Docker Image Build, Tag, Push:               docker build -t apache-php-5.6-magento-environment ./ && docker tag apache-php-5.6-magento-environment devtutspace/apache-php-5.6-magento-environment && docker push devtutspace/apache-php-5.6-magento-environment