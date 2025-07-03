FROM python:3.10

# Dépendances système
RUN apt-get update && apt-get install -y \
    git wget python3-dev build-essential \
    libxslt-dev libzip-dev libldap2-dev libsasl2-dev \
    libpq-dev libjpeg-dev libpq-dev libjpeg-dev zlib1g-dev \
    libffi-dev libssl-dev libxml2-dev libjpeg8-dev \
    liblcms2-dev libblas-dev libatlas-base-dev libtiff5-dev \
    libopenblas-dev libpng-dev libxrender-dev xfonts-75dpi xfonts-base \
    && apt-get clean

# Créer l’utilisateur odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

WORKDIR /opt/odoo

# Copier requirements et installer les dépendances
COPY requirements.txt .
RUN pip3 install --upgrade pip && pip3 install -r requirements.txt

# Cloner Odoo 17 Community
RUN git clone https://www.github.com/odoo/odoo --depth 1 --branch 17.0 --single-branch .

# Copier les autres fichiers
COPY --chown=odoo:odoo . .

RUN chmod +x entrypoint.sh

EXPOSE 8069

USER odoo

ENTRYPOINT ["./entrypoint.sh"]
