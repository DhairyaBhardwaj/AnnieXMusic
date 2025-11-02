FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y --no-install-recommends git ffmpeg build-essential libssl-dev && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -y build-essential libssl-dev && \   # ✅ remove dev tools, keep git & ffmpeg
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY . .

CMD ["python3", "-m", "ANNIEMUSIC"]
