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

# 7. cudatools の key id を確認し最後の8ケタをスペースなしで控える (例：EB69 3B3B)
sudo apt-key list

# 8. keyrings ディレクトリを作成
sudo mkdir -p /etc/apt/keyrings

# 9. キーをエクスポート（EB693B3B の部分は実際のキーIDに置き換え）
sudo apt-key export EB693B3B | sudo gpg --dearmor --yes -o /etc/apt/keyrings/cuda-archive-keyring.gpg

#10. リポジトリ設定ファイルを更新
echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" | sudo tee /etc/apt/sources.list.d/cuda-ubuntu2204-x86_64.list

#11. 古いキーを削除
sudo apt-key del EB693B3B

#12. apt を更新
sudo apt update

#13. 重複しているファイルを削除
sudo rm /etc/apt/sources.list.d/archive_uri-https_developer_download_nvidia_com_compute_cuda_repos_ubuntu2204_x86_64_-jammy.list

#14. apt を更新
sudo apt update


```