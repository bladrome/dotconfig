#!/usr/bin/env bash

sed -i 's/dl-cdn.alpinelinux.org/mirrors.bfsu.edu.cn/g' /etc/apk/repositories
apk update
apk upgrade



apk add zsh neofetch tmux python3 rsync grep awk sed

apk add neovim highlight highlight-doc

apk add build-base clang clang-doc nasm nasm-doc

apk add man man-pages mdocml-apropos less less-doc

apk add curl curl-dev curl-doc openssh openssh-doc git git-doc


# openssh
apk add openssh
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
/usr/sbin/sshd


# ohmyzsh
git clone https://codechina.csdn.net/mirrors/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# chage shell
nvim /etc/passwd
