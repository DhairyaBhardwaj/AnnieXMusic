FROM python:3.12-slim

WORKDIR /app

# Copy dependencies first (for better Docker caching)
COPY requirements.txt .

# Install required system packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ffmpeg \
        libgl1 \
        libglib2.0-0 \
        && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

# Copy your project
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PORT=8080

# Use Gunicorn for production (no Flask dev warnings)
CMD ["gunicorn", "--workers", "4", "--threads", "2", "--bind", "0.0.0.0:8080", "ANNIEMUSIC.__main__:app"]
