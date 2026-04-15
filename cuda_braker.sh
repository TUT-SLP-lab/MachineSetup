# 1. すべてのNVIDIAおよびCUDAパッケージを安全に完全削除（shell展開エラーを防ぐため引用符を使用）
sudo apt-get purge -y '*nvidia*' '*cuda*' '*cudnn*' '*cublas*' '*nsight*'

# 2. 不要になった依存関係をクリーンアップ
sudo apt-get autoremove -y
sudo apt-get autoclean

# 3. 残存している物理ディレクトリを削除
sudo rm -rf /usr/local/cuda*

# 4a. 古いリポジトリソースとGPGキーを削除（再インストール時の競合を防止）
sudo rm -f /etc/apt/sources.list.d/*cuda*.list
sudo rm -f /etc/apt/sources.list.d/*nvidia*.list
sudo rm -f /usr/share/keyrings/*cuda*.gpg
sudo rm -f /usr/share/keyrings/*nvidia*.gpg

# 4b. CUDA/NVIDIAパッケージのpinning設定ファイルを削除（意図しない優先順位の固定を解除）
sudo rm -f /etc/apt/preferences.d/cuda-repository-pin-*
sudo rm -f /etc/apt/preferences.d/*cuda*
sudo rm -f /etc/apt/preferences.d/*nvidia*

# 5. システムのライブラリパスとリンカ設定をクリア
sudo rm -f /etc/profile.d/cuda.sh
sudo rm -f /etc/ld.so.conf.d/cuda*.conf
sudo ldconfig

# 6. .bashrcから不要な環境変数設定を削除
sed -i '/# ===== CUDA 12.8 Configuration START =====/,/# ===== CUDA 12.8 Configuration END =====/d' ~/.bashrc

# 7. 現在のターミナルセッションの環境変数をリセット
unset CUDA_VERSION
unset CUDA_HOME
unset CUDA_PATH
unset NVCC
unset TORCH_ALLOW_TF32_CUBLAS_OVERRIDE
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')
export LIBRARY_PATH=$(echo "$LIBRARY_PATH" | tr ':' '\n' | grep -v cuda | tr '\n' ':' | sed 's/:$//')

# 8. クリーンな状態でパッケージリストを更新
sudo apt-get update

echo "システムのクリーンアップが完了しました。互換性のないDockerイメージを確認し、削除してください。"
