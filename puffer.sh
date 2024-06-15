#!/bin/bash

NGROK_AUTH_TOKEN="YOUR_NGROK_AUTH_TOKEN"  # Replace with your actual Ngrok auth token

echo "DRACOVM - PufferPanel Installation"

# Install PufferPanel repository
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash

# Install PufferPanel
sudo apt-get install -y pufferpanel

# Enable PufferPanel service
sudo systemctl enable --now pufferpanel

# Add admin user (replace details with your own)
sudo pufferpanel user add --email mopifyzai@gmail.com --name foxytoux --password m --admin

# Set Ngrok auth token (optional but recommended)
echo "Setting Ngrok auth token..."
ngrok authtoken $NGROK_AUTH_TOKEN

# Start ngrok
echo "Starting ngrok tunnel..."
ngrok http 8080 &

echo "PufferPanel is now running at: http://$(ngrok http 8080 -c | grep -oE 'https?://[a-z0-9.-]+')"
echo "Installation complete!"
