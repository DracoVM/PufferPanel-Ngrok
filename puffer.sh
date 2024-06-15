#!/bin/bash

# Replace these placeholders with your actual values
NGROK_AUTH_TOKEN="YOUR_NGROK_AUTH_TOKEN"
DATABASE_HOST="db"  # Replace with your database host
DATABASE_NAME="pufferpanel"  # Replace with your database name
DATABASE_USER="root"  # Replace with your database user
DATABASE_PASSWORD="password"  # Replace with your database password
REDIS_HOST="redis"  # Replace with your Redis host
REDIS_PORT="6379"  # Replace with your Redis port
REDIS_PASSWORD="password"  # Replace with your Redis password
REDIS_DATABASE="0"  # Replace with your Redis database

docker run -d \
  -p 80:80 \
  -p 443:443 \
  --name pufferpanel \
  -v $(pwd)/pufferpanel:/app/pufferpanel \
  -v $(pwd)/ngrok.yml:/app/ngrok.yml \
  -e NGROK_AUTH_TOKEN=$NGROK_AUTH_TOKEN \
  -e PUFFERPANEL_HOST=0.0.0.0 \
  -e PUFFERPANEL_PORT=80 \
  -e PUFFERPANEL_URL=http://localhost:80 \
  -e PUFFERPANEL_DATABASE_HOST=$DATABASE_HOST \
  -e PUFFERPANEL_DATABASE_NAME=$DATABASE_NAME \
  -e PUFFERPANEL_DATABASE_USER=$DATABASE_USER \
  -e PUFFERPANEL_DATABASE_PASSWORD=$DATABASE_PASSWORD \
  -e PUFFERPANEL_REDIS_HOST=$REDIS_HOST \
  -e PUFFERPANEL_REDIS_PORT=$REDIS_PORT \
  -e PUFFERPANEL_REDIS_PASSWORD=$REDIS_PASSWORD \
  -e PUFFERPANEL_REDIS_DATABASE=$REDIS_DATABASE \
  -e PUFFERPANEL_INSTALL_CONFIG=1 \
  -e PUFFERPANEL_INSTALL_NGROK=1 \
  -e PUFFERPANEL_INSTALL_NGROK_URL=http://localhost:80 \
  pufferpanel/pufferpanel:latest

# Start ngrok after the container is running
ngrok http 80
