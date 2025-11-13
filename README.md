# MachineSetup
研究室のマシンセットアップスクリプト

`other_installer.sh` は `sudo` を付けずに実行してください．

## Trouble Shooting
### cuda_install_12.8.sh
#### cuda-toolkit-12-8 がインストールできない！
以下を試す
```bash
# 1. GPGキーを追加
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub

# 2. CUDA リポジトリを手動で追加
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"

# 3. apt を更新
sudo apt update

# 4. リポジトリが追加されたか確認
ls /etc/apt/sources.list.d/ | grep cuda

# 5. CUDA パッケージを検索
apt search cuda-toolkit-12-8

# 6. CUDA Toolkit をインストール
sudo apt install -y cuda-toolkit-12-8
```