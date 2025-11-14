sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential dkms gcc make wget libglvnd-dev pkg-config
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

# Install NVIDIA driver
# まずは使用可能なドライバを確認
ubuntu-drivers devices
# CONTINUE [Y/N]? を表示するシェルスクリプト
echo "Do you want to continue installing the recommended NVIDIA driver (nvidia-driver-580-open)? (Y/N)"
read answer
if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
    # Yesの場合、if文中では何もしない
    :
else
    echo "Installation aborted by user."
    exit 1
fi
# セキュアブートが無効化されていることを確認
mokutil --sb-state | grep -q 'SecureBoot disabled'
if [ $? -eq 0 ]; then
    :
else
    echo "Secure Boot is enabled. Please disable it in BIOS settings and reboot before proceeding."
    exit 1
fi



sudo apt install -y nvidia-driver-580-open

# CUDA 12.8のインストール
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install -y cuda-toolkit-12-8 cuda-drivers-580
sudo apt install -y libcudnn9-cuda-12 libcudnn9-dev-cuda-12
sudo ln -sf /usr/local/cuda-12.8 /usr/local/cuda

# 環境変数の設定
cat >> ~/.bashrc << 'EOF'

# ===== CUDA 12.8 Configuration START =====
# CUDA 12.8 環境変数
export CUDA_VERSION=12.8
export CUDA_HOME=/usr/local/cuda-${CUDA_VERSION}
export CUDA_PATH=${CUDA_HOME}
export PATH=${CUDA_PATH}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_PATH}/lib64:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${CUDA_PATH}/lib64:${LIBRARY_PATH}
export CUDNN_INCLUDE_DIR=${CUDA_PATH}/include
export CUDNN_LIB_DIR=${CUDA_PATH}/lib64
export NVCC=${CUDA_PATH}/bin/nvcc
export CFLAGS="-I${CUDA_PATH}/include ${CFLAGS}"
EOF

# 使用する GPU に応じて最適化設定を行う
if [[ "$(nvidia-smi --query-gpu=name --format=csv,noheader)" == *"RTX 5090"* ]]; then
    echo "Configuring environment for RTX 5090"
    cat >> ~/.bashrc << 'EOF'

# PyTorch RTX 5090最適化設定
export NVIDIA_TF32_OVERRIDE=1
export TORCH_ALLOW_TF32_CUBLAS_OVERRIDE=1
EOF

fi

cat >> ~/.bashrc << 'EOF'
# ===== CUDA 12.8 Configuration END =====
EOF

source ~/.bashrc

# 上手く行かない場合はREADME.mdのトラブルシューティングを参照