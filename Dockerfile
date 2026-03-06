FROM python:3.12-slim

WORKDIR /app

# Variables utiles
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Dépendances système minimales
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copier les dépendances d'abord pour profiter du cache Docker
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copier tout le projet
COPY . .

# Rendre le script de démarrage exécutable
RUN chmod +x startup.sh

# Port exposé par Streamlit côté Azure
EXPOSE 8000

CMD ["./startup.sh"]