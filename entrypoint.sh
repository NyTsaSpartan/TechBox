#!/bin/bash

# Appliquer les variables Railway dynamiquement si définies
: "${DB_HOST:=db}"
: "${DB_PORT:=5432}"
: "${DB_USER:=odoo}"
: "${DB_PASSWORD:=odoo}"

# Remplacer dynamiquement la config dans odoo.conf
sed -i "s/db_host *=.*/db_host = ${DB_HOST}/" odoo.conf
sed -i "s/db_port *=.*/db_port = ${DB_PORT}/" odoo.conf
sed -i "s/db_user *=.*/db_user = ${DB_USER}/" odoo.conf
sed -i "s/db_password *=.*/db_password = ${DB_PASSWORD}/" odoo.conf

# Lancer Odoo
exec python3 odoo-bin -c odoo.conf
