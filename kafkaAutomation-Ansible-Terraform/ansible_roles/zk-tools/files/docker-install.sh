#!/bin/bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt install -y docker-compose

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ubuntu

cat <<EOF | sudo tee /etc/sysctl.conf
vm.max_map_count=262144
EOF
sudo sysctl --system