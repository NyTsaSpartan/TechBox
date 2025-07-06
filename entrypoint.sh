#!/bin/bash

# Appliquer les variables Railway dynamiquement si définies
: "${DB_HOST:=db}"
: "${DB_PORT:=5432}"
: "${DB_USER:=odoo}"
: "${DB_PASSWORD:=odoo}"

# Modifier le bon fichier de config
CONF_FILE="/etc/odoo/odoo.conf"

sed -i "s/db_host *=.*/db_host = ${DB_HOST}/" $CONF_FILE
sed -i "s/db_port *=.*/db_port = ${DB_PORT}/" $CONF_FILE
sed -i "s/db_user *=.*/db_user = ${DB_USER}/" $CONF_FILE
sed -i "s/db_password *=.*/db_password = ${DB_PASSWORD}/" $CONF_FILE

# Lancer Odoo
exec python3 /opt/odoo/odoo-bin -c $CONF_FILE
