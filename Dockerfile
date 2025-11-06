FROM python:3.12-slim

WORKDIR /app

# Copy dependencies first (for layer caching)
COPY requirements.txt .

# Install dependencies and libraries
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

# Copy the entire project
COPY . .

# Start the bot
CMD ["python3", "-m", "ANNIEMUSIC"]
