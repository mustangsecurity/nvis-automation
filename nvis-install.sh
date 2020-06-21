#!/bin/bash

# INSTALL NVIS
echo "[+] Installing nVis"

# INSTALL/UPDATE GIT
echo "[+] Installing/updating git"
sudo apt install -y git

# UPDATE PACKAGES
echo "[+] Updating packages"
sudo apt update

# CLONE THE REPOSITORY
echo "[+] Installing nVis to /opt/nVis"
cd /opt
sudo git clone https://github.com/mustangsecurity/nVis    # PULL OUR FORK ON THE OFF CHANCE I HAVE TO FIX SHIT

# RUN THE DAMN THING
echo "[+] Starting the project in docker-compose"
cd /opt/nVis
sudo docker-compose up -d

# RUN THE SERVER SCRIPT
echo "[+] Running config script. say a prayer it doesn't go wrong because it's super janky"
cd /

echo "[+] Installing vsFTPD"
sudo apt-get install vsftpd -y

echo "[+] Installing python3-pip"
sudo apt-get install python3-pip -y

echo "[+] Skipping installing docker-compose because it's already installed"

echo "[+] Installing pymongo"
sudo pip3 install pymongo

echo "[+] Backing up vsftpd config, and moving new one"
sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.bak 
sudo cp /opt/nVis/vsftpd.conf /etc/vsftpd.conf

echo "[+] Creating directory for FTP updloads at /var/ftp/pub"
sudo mkdir /var/ftp
sudo mkdir /var/ftp/pub
sudo chown ftp:ftp /var/ftp/pub
sudo chmod 777 /var/ftp/pub

echo "[+] Restarting vsftpd daemon"
sudo systemctl stop vsftpd
sudo systemctl start vsftpd

echo "[+] Disabling firewall"
sudo ufw disable

echo "[+] Starting loop to upload files to server every 60 seconds"
while true
do
echo "[+] Uploading files from /var/ftp/pub to mongoDB"
sudo python3 /opt/nVis/nmaptomongo.py -F /var/ftp/pub
sleep 60
done
