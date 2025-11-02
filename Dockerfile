FROM python:3.12-slim

# Install git and other system dependencies
RUN apt-get update && apt-get install -y git && apt-get clean

# Continue with your normal setup
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "ANNIEMUSIC"]
