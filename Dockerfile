FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

# Install git and other dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ffmpeg build-essential libssl-dev && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade -r requirements.txt && \
    apt-get purge -y build-essential libssl-dev && \  # remove heavy build tools, but keep git
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY . .

CMD ["python3", "-m", "ANNIEMUSIC"]
