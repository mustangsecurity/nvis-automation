#!/bin/bash

# REMOVE OLD VERSIONS OF SOFTWARE
echo "[+] Removing deprecated software (may error, that's okay)"
sudo apt-get remove docker docker-engine docker.io containerd runc docker-ce docker-ce-cli containerd.io -y
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
    software-properties-common \
    -y

# GET DOCKER GPG KEY
echo "[+] Getting Docker's GPG Key"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# GET THE PACKAGE LISTING FOR AMD64
echo "[+] Getting the Docker repository listing"
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list

# UPDATE APT AGAIN
echo "[+] Updating apt again, now that docker's repository is installed"
sudo apt-get update

# INSTALL DOCKER 
echo "[+] Installing Docker Packages"
sudo apt-get install docker-ce -y

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
sudo curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep browser_download_url \
  | grep docker-compose-Linux-x86_64 \
  | cut -d '"' -f 4 \
  | wget -qi -

# CHANGE BINARY PERMISSIONS
echo "[+] Changing permissions of the compose binary"
sudo chmod +x docker-compose-Linux-x86_64

# EXPORT BINARY TO PATH
echo "[+] Moving the compose binary to the PATH"
sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose

# DONE
echo "[+] Finished installing docker-compose."
echo "[+] Confirming docker-compose version. If this fails, your install failed"
sudo docker-compose version