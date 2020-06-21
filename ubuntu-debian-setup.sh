#!/bin/bash

# REMOVE OLD VERSIONS OF SOFTWARE
echo "[+] Removing deprecated software (may error, that's okay)"
sudo apt-get remove docker docker-engine docker.io containerd runc -y
echo "[+] Finished removing deprecated software"

# GET UPDATES
echo "[+] Updating apt repository lists"
sudo apt update
echo "[+] Finished updating apt repository lists"

# INSTALL DOCKER
echo "[+] Installing Docker:"

# DOCKER-SPECIFIC DEPENDENCIES
echo "[+] Getting Docker-specific dependencies:"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    -y

# GET DOCKER GPG KEY
echo "[+] Getting Docker's GPG Key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# GET THE PACKAGE LISTING FOR AMD64
echo "[+] Getting the Docker repository listing"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# UPDATE APT AGAIN
echo "[+] Updating apt again, now that docker's repository is installed"
sudo apt-get update

# INSTALL DOCKER 
echo "[+] Installing Docker Packages"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# START THE DOCKER DAEMON
echo "[+] Starting the docker daemon"
sudo systemctl start docker

# ENABLE THE DOCKER DAEMON
echo "[+] Enabling the Docker Daemon"
sudo systemctl enable docker

# CONFIRM VERSION
echo ""
echo "[+] Done installing Docker!. Confirming version. If this fails, your install failed"
sudo docker version

# DONE, NOW INSTALL DOCKER-COMPOSE
echo ""
echo "[+] Installing docker-compose"

# INSTALL DEPENDENCIES
echo "[+] Installing dependencies"
sudo apt install -y curl

# GRAB DOCKER-COMPOSE BINARY
echo "[+] Grabbing the latest version of docker-compose"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# CHANGE BINARY PERMISSIONS
echo "[+] Changing permissions of the compose binary"
sudo chmod +x /usr/local/bin/docker-compose

# DONE
echo "[+] Finished installing docker-compose."
echo "[+] Confirming docker-compose version. If this fails, your install failed"
sudo docker-compose --version