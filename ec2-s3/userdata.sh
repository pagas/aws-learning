#!/bin/bash
set -e

# Update system
dnf update -y

# Install Node.js 22 and Git
dnf install -y nodejs git

# Install PM2 globally
npm install -g pm2

# Define the working directory
APP_DIR="/home/ec2-user/aws-learning"

# Clone and setup as ec2-user to avoid permission issues
sudo -u ec2-user git clone https://github.com/pagas/aws-learning.git $APP_DIR
cd $APP_DIR/ec2-s3

# Install dependencies as ec2-user
sudo -u ec2-user npm install --omit=dev

# Start app with PM2 as ec2-user
sudo -u ec2-user pm2 start npm --name myapp -- start

# Enable reboot persistence
# This tells PM2 to freeze the current process list for ec2-user
sudo -u ec2-user pm2 save

# Automatically generate and run the startup script for systemd
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user