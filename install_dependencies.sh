#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Check if Node.js is installed, if not install it
if ! command -v node &> /dev/null; then
    echo "Node.js not found. Installing..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo "Node.js is already installed."
fi

# Check if PM2 is installed, if not install it
if ! command -v pm2 &> /dev/null; then
    echo "PM2 not found. Installing..."
    sudo npm install -g pm2
else
    echo "PM2 is already installed."
fi

# Check if Nginx is installed, if not install it
if ! command -v nginx &> /dev/null; then
    echo "Nginx not found. Installing..."
    sudo apt install -y nginx
    sudo ufw app list
    sudo ufw allow 'Nginx Full'
    sudo ufw status
else
    echo "Nginx is already installed."
fi

# Check if Git is installed, if not install it
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing..."
    sudo apt install -y git
else
    echo "Git is already installed."
fi

# Check if Certbot is installed, if not install it
if ! command -v certbot &> /dev/null; then
    echo "Certbot not found. Installing..."
    sudo apt install -y certbot python3-certbot-nginx
else
    echo "Certbot is already installed."
fi