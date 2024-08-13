#!/bin/bash

cd

username=`whoami`
hostname=`hostname -s`

git config --global user.name "${username^} ${hostname^}"
git config --global user.email ${username}@$(hostname)

[ -d "you-git" ] || git clone git@github.com:madixi/you-git.git
