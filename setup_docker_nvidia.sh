#!/bin/bash

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
	&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
	&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker
sudo docker pull nvidia/cuda:11.6.0-base-ubuntu20.04

DATE=`date '+%Y%m%d'`
mv /etc/docker/daemon.json /etc/docker/daemon.json.$DATE
cp ./daemon.json /etc/docker/daemon.json
sudo systemctl restart docker


