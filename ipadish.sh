#!/usr/bin/env bash

sed -i 's/dl-cdn.alpinelinux.org/mirrors.bfsu.edu.cn/g' /etc/apk/repositories
apk update
apk upgrade
apk add zsh git neofetch curl neovim tmux openssh python3

# openssh
add openssh
ssh-keygen -A
passwd
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
/usr/sbin/sshd


# ohmyzsh
git clone https://codechina.csdn.net/mirrors/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# chage shell
nvim /etc/passwd
# chsh -s $(which zsh)
