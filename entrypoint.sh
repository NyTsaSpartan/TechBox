#!/bin/bash

: "${DB_HOST:=db}"
: "${DB_PORT:=5432}"
: "${DB_USER:=odoo}"
: "${DB_PASSWORD:=odoo}"
: "${DB_NAME:=postgres}"

# Mise à jour de la config
sed -i "s/db_host *=.*/db_host = ${DB_HOST}/" /etc/odoo/odoo.conf
sed -i "s/db_port *=.*/db_port = ${DB_PORT}/" /etc/odoo/odoo.conf
sed -i "s/db_user *=.*/db_user = ${DB_USER}/" /etc/odoo/odoo.conf
sed -i "s/db_password *=.*/db_password = ${DB_PASSWORD}/" /etc/odoo/odoo.conf

exec python3 /opt/odoo/odoo-bin -c /etc/odoo/odoo.conf
