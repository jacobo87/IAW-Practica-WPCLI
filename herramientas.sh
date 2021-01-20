#!/bin/bash

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



