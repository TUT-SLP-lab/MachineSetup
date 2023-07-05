sudo apt-get --purge remove nvidia*
sudo apt-get --purge remove cuda*
sudo apt-get --purge remove cudnn*
sudo apt-get --purge remove libnvidia*
sudo apt-get --purge remove libcuda*
sudo apt-get --purge remove libcudnn*
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get update
sudo rm -rf /usr/local/cuda*

echo "please confirm docker images (command is same)"
echo "remove unconpatible images"
