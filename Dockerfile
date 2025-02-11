# Use a lightweight Python image as the base
FROM python:3.12-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
  nginx \
  && rm -rf /var/lib/apt/lists/*

# Set up FastAPI app
WORKDIR /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the necessary ports
EXPOSE 80
EXPOSE 8000

# Start Nginx and the FastAPI app (using Uvicorn)
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
