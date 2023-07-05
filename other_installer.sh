sudo apt-get install curl -y
mkdir ~/conda_tmp
cd ~/conda_tmp
pwd
wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
sudo chmod +x Anaconda3-2023.03-Linux-x86_64.sh
bash Anaconda3-2023.03-Linux-x86_64.sh
cd -

sudo apt-fast install tmux -y
sudo apt-fast install vim -y

sudo apt-fast install openssh-server -y
sudo systemctl enable --now ssh
