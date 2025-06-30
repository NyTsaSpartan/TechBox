FROM python:3.10-slim

# Installer les dépendances système d'Odoo
RUN apt-get update && apt-get install -y \
    gcc libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev \
    libpq-dev libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Créer le répertoire de l'app
WORKDIR /app

# Copier le projet
COPY . /app

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Commande de démarrage (à adapter)
CMD ["./odoo-bin", "-d", "railway", "-r", "postgres", "-w", "admin", "--addons-path=addons", "--db_host=db", "--db_port=5432"]
