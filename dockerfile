FROM python:3.10-slim

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    gcc g++ git wget curl python3-dev build-essential \
    libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
    libldap2-dev libjpeg-dev libpq-dev libffi-dev \
    libssl-dev libjpeg8-dev liblcms2-dev libblas-dev \
    libatlas-base-dev libtiff5-dev libopenblas-dev libpng-dev \
    libxrender-dev xfonts-75dpi xfonts-base \
    && apt-get clean

# Créer utilisateur odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

WORKDIR /opt/odoo

# Cloner Odoo 17 Community
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 17.0 --single-branch .

# Copier requirements et installer Python packages
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copier les autres fichiers
COPY --chown=odoo:odoo . .

RUN chmod +x entrypoint.sh

# Exposer le port Odoo
EXPOSE 8069

# Changer d'utilisateur
USER odoo

ENTRYPOINT ["./entrypoint.sh"]
