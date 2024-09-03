#!/bin/bash

echo "Setting up SSL certificate..."
sudo certbot --nginx -d $SERVER_NAME
sudo certbot renew --dry-run

echo "Restarting Nginx..."
sudo systemctl restart nginx