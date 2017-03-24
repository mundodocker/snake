FROM ubuntu


#Instala php e dependencias
RUN apt-get update && \
apt-get -yq install \
make \
apache2 \
libapache2-mod-php \
php \
php-pdo \
php-pdo-mysql \
php-dev \
php-gd \
php-curl \
php-mcrypt \
php-pear \
php-zip \
php-mbstring && \
rm -rf /var/lib/apt/lists/* && \
mkdir -p /etc/php/7.0/mods-available && \
ln -s /etc/php/7.0/mods-available/mcrypt.ini /etc/php/7.0/cli/conf.d/mcrypt.ini && \
ln -s /etc/php/7.0/mods-available/mcrypt.ini/etc/php/7.0/apache2/conf.d/mcrypt.ini

RUN a2enmod headers php7.0 rewrite vhost_alias
ADD run.sh /run.sh
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY . /var/www/html/
RUN chmod +x /run.sh
EXPOSE 80
CMD ["/run.sh"]
