#!/bin/bash

# ####################################
# ## CONFIGURACIÓN DE LAS VARIABLES ##
# ####################################

# IP Pública
IP=http://100.25.111.2

# Directorio de usuario #
HTTPASSWD_DIR=/home/ubuntu

# MySQL #
DB_ROOT_PASSWD=root
DB_NAME=wp_db
DB_USER=wp_user
DB_PASSWORD=wp_pass

# ------------------------------####################--------------------------------
# ------------------------------##   Pila LAMP    ##--------------------------------
# ------------------------------####################--------------------------------

set -x

# Actualizamos los repositorios
apt update
# Instalamos Apache 
apt install apache2 -y

# Instalamos MySQL Server 
apt install mysql-server -y

# Instalamos módulos PHP 
apt install php libapache2-mod-php php-mysql -y

# Reiniciamos el servicio Apache 
systemctl restart apache2


# Creamos la base de datos que vamos a usar con Wordpress #

# Nos aseguramos que no existe ya, y si existe la borramos
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
# Creamos la base de datos
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
# Nos aseguramos que no existe el usuario
mysql -u root <<< "DROP USER IF EXISTS $DB_USER@localhost;"
# Creamos el usuario para Wordpress
mysql -u root <<< "CREATE USER $DB_USER@localhost IDENTIFIED BY '$DB_PASSWORD';"
# Concedemos privilegios al usuario que acabamos de crear
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@localhost;"
# Aplicamos cambios
mysql -u root <<< "FLUSH PRIVILEGES;"


# ------------------------------####################--------------------------------
# ------------------------------##    WP - CLI    ##--------------------------------
# ------------------------------####################--------------------------------

# Nos movemos al directorio de Apache
cd /var/www/html

# Descargamos y guardamos el contenido de wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Le asignamos permisos de ejecución
chmod +x wp-cli.phar

# Movemos el archivo y cambiamos el nombre 
mv wp-cli.phar /usr/local/bin/wp

# Eliminamos index.html
rm -rf index.html

# Descargamos el código fuente de Wordpress en Español y le damos permiso de root
wp core download --path=/var/www/html --locale=es_ES --allow-root

# Le damos permiso a la carpeta de wordpress
chown -R www-data:www-data /var/www/html

# Creamos el archivo de configuración de Wordpress
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

# Instalamos Wordpress
wp core install --url=$IP --title="IAW Jacobo Azmani" --admin_user=admin --admin_password=admin_password --admin_email=test@test.com --allow-root



