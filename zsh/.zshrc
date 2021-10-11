# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias vim='nvim'
export EDITOR='nvim'
PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux
PATH=$PATH:~/.config/emacs/bin
PATH=$PATH:~/tools
PATH=$PATH:~/.local/bin
PATH=$PATH:~/.cargo/bin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zinit/bin/zinit.zsh

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zpm-zsh/material-colors

zinit light zinit-zsh/z-a-meta-plugins
zinit for annexes zsh-users+fast ext-git console-tools #fuzzy

zinit ice lucid wait='1'
zinit light skywind3000/z.lua
zinit light Aloxaf/fzf-tab

zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::history.zsh

bindkey ',' autosuggest-accept

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/run/media/bladrome/drome/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/run/media/bladrome/drome/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/run/media/bladrome/drome/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/run/media/bladrome/drome/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
