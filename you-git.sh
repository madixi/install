#!/bin/bash

set -x

cd

username=`whoami`
hostname=`hostname -s`

git config --global user.name >/dev/null || git config --global user.name "${username^} ${hostname^}"
git config --global user.email >/dev/null || git config --global user.email ${username}@$(hostname)


sudo apt update
sudo apt install -y ffmpeg

dpkg -l yandex-disk > /dev/null 2>&1 || (
    wget -O- http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG | gpg --dearmor > yandex-disk.gpg
    sudo install -D -o root -g root -m 644 yandex-disk.gpg /etc/apt/keyrings/yandex-disk.gpg
    echo "deb [signed-by=/etc/apt/keyrings/yandex-disk.gpg] http://repo.yandex.ru/yandex-disk/deb/ stable main" | sudo tee /etc/apt/sources.list.d/yandex-disk.list > /dev/null
    rm yandex-disk.gpg
    sudo apt update
    sudo apt install -y wget gpg yandex-disk
)

pip3 install --user -U ffmpeg-python

mkdir -p 1you-git/yandex-disk

[ -d "you-git" ] || git clone git@github.com:madixi/you-git.git
cd you-git
git pull
cp you_git.py ../1you-git/

sudo cp ya-dsk.service /etc/systemd/system/ya-dsk.service
sudo systemctl --system daemon-reload

cd
