#!/bin/bash

cd

username=`whoami`
hostname=`hostname -s`

git config --global user.name >/dev/null || git config --global user.name "${username^} ${hostname^}"
git config --global user.name >/dev/null || git config --global user.email ${username}@$(hostname)

mkdir -p 1you-git
[ -d "you-git" ] || git clone git@github.com:madixi/you-git.git
cd you-git
git pull
cp you-git/you-git.py ../1you-git
cd
