#!/bin/bash
set -e  # エラーで即停止

# =====================================================
# 1. NVIDIAおよびCUDAパッケージの削除
#    - ワイルドカードはシェル展開バグ防止のためクォートで囲む
#    - cuda-* で cuda-toolkit-12-8 系を、libcuda* で libcuda1 系を両方カバー
#    - 部分一致（*cuda*）は使用しない（無関係パッケージの巻き込み防止）
# =====================================================
sudo apt-get purge -y \
  'nvidia-*' \
  'cuda-*' \
  'libcuda*' \
  'cudnn-*' \
  'libcudnn*' \
  'libnvidia-*' \
  'libcublas-*' \
  'nsight-*'

# 2. 不要な依存関係の削除
sudo apt-get autoremove -y
sudo apt-get autoclean

# =====================================================
# 3. 物理ディレクトリの削除
# =====================================================
sudo rm -rf /usr/local/cuda*

# =====================================================
# 4. リポジトリソースとGPGキーの削除
#    【重要】.list と GPGキーは必ずセットで削除すること。
#    片方だけ残すと apt-get update 時にGPGエラーが発生する。
#    再インストール時はNVIDIAの公式インストールスクリプトが
#    GPGキーを自動登録するため、手動対応は不要。
# =====================================================
sudo rm -f /etc/apt/sources.list.d/*cuda*.list
sudo rm -f /etc/apt/sources.list.d/*nvidia*.list
sudo rm -f /usr/share/keyrings/*cuda*.gpg
sudo rm -f /usr/share/keyrings/*nvidia*.gpg

# 5. ピンニングファイルの削除（再インストール時の優先順位コンフリクト防止）
sudo rm -f /etc/apt/preferences.d/cuda-repository-pin-*
sudo rm -f /etc/apt/preferences.d/*cuda*
sudo rm -f /etc/apt/preferences.d/*nvidia*

# =====================================================
# 6. システムライブラリパス・リンカ設定のクリア
# =====================================================
sudo rm -f /etc/profile.d/cuda.sh
sudo rm -f /etc/ld.so.conf.d/cuda*.conf
sudo ldconfig

# =====================================================
# 7. .bashrc からCUDA環境変数設定を削除
# =====================================================
sed -i '/# ===== CUDA 12.8 Configuration START =====/,/# ===== CUDA 12.8 Configuration END =====/d' ~/.bashrc

# 8. 現在のターミナルセッションの環境変数をリセット
unset CUDA_VERSION CUDA_HOME CUDA_PATH
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LIBRARY_PATH=$(echo "$LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')

# =====================================================
# 9. パッケージリストを更新
# =====================================================
sudo apt-get update

echo "クリーンアップ完了。Dockerイメージに互換性のないものが残っていないか確認してください。"
