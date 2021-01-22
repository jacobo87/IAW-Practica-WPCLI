#!/bin/bash

set -x

# #################################################
# ##     Instalación de herramientas para WP     ##
# #################################################

# Actualizamos los plugin a su última versión
wp plugin update --all --path=/var/www/html/ --allow-root

# Actualizamos los temas a su última versión
wp theme update --all --path=/var/www/html/ --allow-root

# Instalamos el plugin deseado 
# Plugin elegido WP Githuber MD
wp plugin install --path=/var/www/html/ wp-githuber-md --activate --allow-root

# Instalamos el tema que queremos
# En este caso hemos elegido el tema Bravada
wp theme install --path=/var/www/html/ bravada --activate --allow-root

# Instalamos Ruby
apt install ruby -y

# Instalamos dependencias de Ruby
apt install build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev  libgmp-dev zlib1g-dev -y

# Instalamos la herramienta de auditoria
gem install wpscan
# Actualizamos
wpscan --update

# Enumeramos los usuarios
wpscan --url http://54.173.16.66 --enumerate u

