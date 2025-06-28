FROM python:3.10-slim

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    git build-essential python3-dev libxml2-dev libxslt1-dev zlib1g-dev \
    libldap2-dev libsasl2-dev libpq-dev gcc \
    libjpeg-dev libffi-dev libssl-dev liblcms2-dev libblas-dev libatlas-base-dev \
    libjpeg8-dev libtiff5-dev libopenjp2-7-dev libwebp-dev libharfbuzz-dev \
    libfribidi-dev libxcb1-dev fonts-noto-cjk

# Copier le code
WORKDIR /app
COPY . .

# Installer les dépendances Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Lancer Odoo
CMD ["./odoo-bin", "--addons-path=addons", "--db_host=${PGHOST}", "--db_port=${PGPORT}", "--db_user=${PGUSER}", "--db_password=${PGPASSWORD}", "--db_name=${PGDATABASE}", "--xmlrpc-port=${PORT}", "--log-level=info"]
