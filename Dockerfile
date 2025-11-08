# ---------- Base image ----------
FROM python:3.12-slim

# ---------- Set environment variables ----------
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

# ---------- Set working directory ----------
WORKDIR /app

# ---------- Copy files ----------
COPY . .

# ---------- Install required system packages ----------
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

# ---------- Optional: Pre-install prebuilt tgcrypto wheel ----------
# (This skips compiling tgcrypto from source)
# RUN pip install --no-cache-dir tgcrypto==1.2.5 --only-binary=:all:

# ---------- Default command ----------
CMD ["python3", "main.py"]
