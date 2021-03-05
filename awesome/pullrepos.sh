#!/usr/bin/env bash
set -euo pipefail
set -x

if [ -e the-glorious-dotfiles ]
then
    cd the-glorious-dotfiles
    git pull
    cd ..
else
    gh repo clone manilarome/the-glorious-dotfiles


fi

# manilarome/the-glorious-dotfiles
for config in floppy gnawesome surreal
do
    configdir=$config/.config/awesome
    mkdir -p $configdir
    cp -r the-glorious-dotfiles/config/awesome/$config/* $configdir
    cp -rf linear/.config/awesome/configuration $configdir
done
