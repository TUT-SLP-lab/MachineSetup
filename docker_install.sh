#!/bin/bash

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl --insecure -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt autoremove

sudo curl --insecure -fsSL https://downloads.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archiv
e-keyring.gpg
sudo apt update
sudo apt install docker-ce
sudo apt autoremove

sudo docker version
sudo systemctl status docker
sudo apt autoremove

sudo curl --insecure -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v
