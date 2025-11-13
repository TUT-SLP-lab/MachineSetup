sudo apt-get --purge remove nvidia*
sudo apt-get --purge remove cuda*
sudo apt-get --purge remove cudnn*
sudo apt-get --purge remove libnvidia*
sudo apt-get --purge remove libcuda*
sudo apt-get --purge remove libcudnn*
sudo apt-get --purge remove *cublas*
sudo apt-get --purge remove nsight*
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get update
sudo rm -rf /usr/local/cuda*

# sudo rm -f /etc/apt/sources.list.d/*cuda*.list
# sudo rm -f /etc/apt/sources.list.d/*nvidia*.list

sudo apt-get update

sed -i '/# ===== CUDA 12.8 Configuration START =====/,/# ===== CUDA 12.8 Configuration END =====/d' ~/.bashrc
# sudo rm -f /usr/share/keyrings/*cuda*.gpg
# sudo rm -f /usr/share/keyrings/*nvidia*.gpg
# sudo rm -f /etc/profile.d/cuda.sh
# sudo rm -f /etc/ld.so.conf.d/cuda*.conf
sudo ldconfig
unset CUDA_VERSION
unset CUDA_HOME
unset CUDA_PATH
unset NVCC
unset TORCH_ALLOW_TF32_CUBLAS_OVERRIDE
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LIBRARY_PATH=$(echo "$LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')



echo "please confirm docker images (command is same)"
echo "remove unconpatible images"
