sudo add-apt-repository ppa:apt-fast/stable
sudo apt -y install apt-fast
sudo apt-fast -y install linux-headers-$(uname -r)
sudo wget -O /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt-fast -y update
sudo apt-fast -y upgrade
sudo apt-fast -y install cuda-11-6
export CUDA_PATH=/usr/local/cuda-11.6
echo 'export CUDA_PATH=/usr/local/cuda-11.6' | sudo tee -a /etc/profile.d/cuda-path.sh
export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64:${LD_LIBRARY_PATH}
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64:${LD_LIBRARY_PATH}' | sudo tee -a /etc/profile.d/cuda-path.sh
export PATH=/usr/local/cuda-11.6/bin:${PATH}
echo 'export PATH=/usr/local/cuda-11.6/bin:${PATH}' | sudo tee -a /etc/profile.d/cuda-path.sh
cd /tmp
wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb
sudo dpkg -i nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb
sudo apt-fast -y update
sudo apt-fast -y install libcudnn8 libcudnn8-dev openssh-server
sudo systemctl enable --now ssh
sudo /sbin/shutdown -r now
