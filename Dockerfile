# ---------- Base Image ----------
FROM python:3.12-slim

# ---------- Environment Settings ----------
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive \
    PORT=8080

# ---------- Set Working Directory ----------
WORKDIR /app

# ---------- Copy Project Files ----------
COPY . .

# ---------- Install System Dependencies ----------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ffmpeg \
        libgl1 \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender-dev \
        build-essential \
        && \
    pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

# ---------- Health Check ----------
HEALTHCHECK CMD curl --fail http://localhost:$PORT || exit 1

# ---------- Default Command ----------
CMD ["python3", "-m", "ANNIEMUSIC"]
