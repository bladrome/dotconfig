[[ $- != *i* ]] && return

alias ls='ls --color'
alias ll='ls -al'
export EDITOR='nvim'
alias vim='nvim'
alias ca='conda activate'
#alias for npm
alias npm="npm --registry=https://registry.npmmirror.com \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npmmirror.com/mirrors/node \
  --userconfig=$HOME/.cnpmrc"

PATH=$PATH:~/.config/emacs/bin
PATH=$PATH:~/tools
PATH=$PATH:~/.local/bin
PATH=$PATH:~/.cargo/bin
PATH=$PATH:~/node_modules/.bin
PATH=$PATH:~/gitcode/bladrome/cvscripts
source ~/tools/loadproxy.sh


# https://wiki.zshell.dev/docs/getting_started/installation#-manual-setup
typeset -Ag ZI
export ZI[HOME_DIR]="${HOME}/.zi"
export ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
command mkdir -p "$ZI[BIN_DIR]"

if [[ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  chown -R "$(whoami)" "$ZI[HOME_DIR]"
  chmod -R go-w "$ZI[HOME_DIR]"
  git clone --depth 1 https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"
fi

typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi


# zi self-update

zi light-mode for \
 z-shell/z-a-meta-plugins skip'F-Sy-H' \
 @annexes \
 @ext-git \
 @fuzzy


zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions

zi pack for dircolors-material
zi light dircolors-material
zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship

zi snippet OMZL::clipboard.zsh
zi snippet OMZL::termsupport.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::history.zsh

# conda

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/run/media/bladrome/bank/drome/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/run/media/bladrome/bank/drome/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/run/media/bladrome/bank/drome/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/run/media/bladrome/bank/drome/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/run/media/bladrome/bank/drome/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/run/media/bladrome/bank/drome/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
