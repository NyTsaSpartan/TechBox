FROM python:3.10-slim

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    gcc g++ git wget curl build-essential \
    libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
    libldap2-dev libjpeg-dev libpq-dev libffi-dev \
    libssl-dev libjpeg8-dev liblcms2-dev libblas-dev \
    libatlas-base-dev libtiff5-dev libopenblas-dev libpng-dev \
    libxrender-dev xfonts-75dpi xfonts-base \
    && apt-get clean

# Créer utilisateur odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Répertoire de travail
WORKDIR /opt/odoo

# Cloner Odoo 18
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 --single-branch .

# Copier les dépendances et installer
COPY requirements.txt /opt/odoo/
RUN pip install --upgrade pip && pip install -r /opt/odoo/requirements.txt

# Copier les modules, config, script
COPY --chown=odoo:odoo addons /opt/odoo/addons
COPY --chown=odoo:odoo odoo.conf /etc/odoo/odoo.conf
COPY --chown=odoo:odoo entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exposer le port Odoo
EXPOSE 8069

# Utilisateur non-root
USER odoo

# Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
