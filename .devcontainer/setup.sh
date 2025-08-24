#!/bin/bash
set -e

echo "🚀 Setting up Codespace as Ansible deployment target..."

# Update system and install packages
sudo apt-get update
sudo apt-get install -y \
    openssh-server \
    nginx \
    curl \
    wget \
    git \
    htop \
    tree \
    python3 \
    python3-pip \
    python3-venv \
    supervisor \
    unzip

# Configure SSH server
sudo systemctl enable ssh
sudo mkdir -p /var/run/sshd

# Create SSH key pair for GitHub Actions
mkdir -p ~/.ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/ansible_key -N "" -C "github-actions-key"

# Setup authorized keys
cat ~/.ssh/ansible_key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/ansible_key

# Configure SSH daemon
sudo tee /etc/ssh/sshd_config.d/codespace.conf > /dev/null <<EOFINNER
Port 22
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PermitRootLogin no
AllowUsers codespace
ClientAliveInterval 60
ClientAliveCountMax 3
EOFINNER

# Start services
sudo systemctl start ssh
sudo systemctl enable nginx
sudo systemctl start nginx

# Create application directories
sudo mkdir -p /opt/deployments /var/www/lab8
sudo chown -R codespace:codespace /opt/deployments /var/www/lab8

# Install Python packages
pip3 install --user flask gunicorn supervisor

echo "✅ Codespace setup complete!"
echo ""
echo "📋 COPY THIS SSH PRIVATE KEY TO GITHUB SECRETS AS 'SSH_PRIVATE_KEY':"
echo "=========================================="
cat ~/.ssh/ansible_key
echo "=========================================="
echo ""
echo "🌐 Use 'gh codespace ports' to see forwarded URLs"
