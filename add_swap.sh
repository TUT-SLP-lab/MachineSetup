#!/bin/bash

echo "script="$0
echo "arg count="$#

# MB単位で受け取る 例)2GB=2048
SWAP_COUNT=${1}

sudo dd if=/dev/zero of=/swapfile bs=1M count=${SWAP_COUNT}

sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo swapon -s

# sudo 権限で/etc/fstabに書き込み、永続化
sudo sh -c 'echo /swapfile swap swap defaults 0 0 >>/etc/fstab'

