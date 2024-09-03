#!/bin/bash

# Accept input
read -p "Enter your server name (domain or IP): " SERVER_NAME
read -p "Enter the Git repository URL: " REPO_URL
read -p "Enter the port your app will run on: " APP_PORT

./install_dependencies.sh
    
# Ensure Nginx is started and enabled to start on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Clone the repository
sudo mkdir -p /var/www/$SERVER_NAME
sudo git clone $REPO_URL /var/www/$SERVER_NAME

# Set up Nginx server block
cat << EOF | sudo tee /etc/nginx/sites-available/$SERVER_NAME
server {
    listen 80;
    server_name $SERVER_NAME;

    root /var/www/$SERVER_NAME;
    index index.html index.htm;

    location / {
        proxy_pass http://localhost:$APP_PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Create a symbolic link to enable the site
sudo ln -s /etc/nginx/sites-available/$SERVER_NAME /etc/nginx/sites-enabled/

# Remove default Nginx site
sudo rm /etc/nginx/sites-enabled/default

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply changes
sudo systemctl reload nginx

echo "Installation and setup complete!"
echo "Your app has been cloned to /var/www/$SERVER_NAME"
echo "Remember to set up your Node.js app and start it with PM2"
