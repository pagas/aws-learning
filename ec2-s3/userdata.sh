
#!/bin/bash
set -e

# ---------------------------
# Update system
# ---------------------------
dnf update -y

# ---------------------------
# Install Node.js 22
# ---------------------------
dnf install -y nodejs-22

# ---------------------------
# Install Git
# ---------------------------
dnf install -y git

# ---------------------------
# Install PM2 globally
# ---------------------------
npm install -g pm2

# ---------------------------
# Fetch your application
# (REPLACE with your repository)
# ---------------------------
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git /app
cd /app

# ---------------------------
# Install dependencies
# ---------------------------
npm install --omit=dev

# ---------------------------
# Start the app with PM2
# ---------------------------
pm2 start npm --name myapp -- start

# ---------------------------
# PM2: enable reboot persistence
# ---------------------------
pm2 save
pm2 startup systemd -u ec2-user --hp /home/ec2-user
