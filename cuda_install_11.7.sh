uname -m
lsb_release -sc
cat /etc/*release
sudo wget -O /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt-cache search cuda-11
sudo apt-fast -y update
sudo apt-fast -y install cuda-11-7
sudo update-initramfs -u

export CUDA_PATH=/usr/local/cuda-11.7
echo 'export CUDA_PATH=/usr/local/cuda-11.7' | sudo tee -a /etc/profile.d/cuda-path.sh
export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:${LD_LIBRARY_PATH}
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:${LD_LIBRARY_PATH}' | sudo tee -a /etc/profile.d/cuda-path.sh
export PATH=/usr/local/cuda-11.7/bin:${PATH}
echo 'export PATH=/usr/local/cuda-11.7/bin:${PATH}' | sudo tee -a /etc/profile.d/cuda-path.sh

sudo /sbin/shutdown -r now
