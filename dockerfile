FROM python:3.10-slim

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    gcc g++ git wget curl python3-dev build-essential \
    libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
    libldap2-dev libjpeg-dev libpq-dev libffi-dev \
    libssl-dev libjpeg8-dev liblcms2-dev libblas-dev \
    libatlas-base-dev libtiff5-dev libopenblas-dev libpng-dev \
    libxrender-dev xfonts-75dpi xfonts-base \
    && apt-get clean

# Créer l'utilisateur odoo
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Définir le dossier de travail
WORKDIR /opt/odoo

# Cloner Odoo 18
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 --single-branch .

# Donner les droits d’exécution sur odoo-bin (après clone)
RUN chmod +x /opt/odoo/odoo-bin && chown odoo:odoo /opt/odoo/odoo-bin

# Copier requirements et installer les dépendances Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copier les modules, le script et la conf
COPY --chown=odoo:odoo addons/ ./addons/
COPY --chown=odoo:odoo entrypoint.sh /entrypoint.sh
COPY --chown=odoo:odoo odoo.conf /etc/odoo/odoo.conf

# Rendre le script de démarrage exécutable
RUN chmod +x /entrypoint.sh

# Exposer le port
EXPOSE 8069

# Utiliser l'utilisateur odoo
USER odoo

# Lancer le script
ENTRYPOINT ["/entrypoint.sh"]
