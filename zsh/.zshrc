[[ $- != *i* ]] && return



declare -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
if [[ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing interactive feature-rich plugin manager (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "${ZI[BIN_DIR]}" && command chmod g-rwX "${ZI[BIN_DIR]}"
  command git clone -q https://github.com/z-shell/zi.git "${ZI[BIN_DIR]}" && \
  print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# Z-Shell ZI Annexes
zi light-mode for z-shell/z-a-meta-plugins annexes




alias ls='ls --color=auto'
alias ll='ls -l'
alias vim='nvim'
export EDITOR='nvim'
PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-linux
PATH=$PATH:~/.config/emacs/bin
PATH=$PATH:~/tools
PATH=$PATH:~/.local/bin
PATH=$PATH:~/.cargo/bin
PATH=$PATH:~/node_modules/.bin
PATH=$PATH:~/gitcode/bladrome/cvscripts



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zi ice depth=1; zi light romkatv/powerlevel10k

zi light zpm-zsh/material-colors

zi light z-shell/z-a-meta-plugins
zi for annexes zsh-users+fast ext-git console-tools fuzzy

zi ice lucid wait='1'
zi light skywind3000/z.lua
zi light Aloxaf/fzf-tab


zi snippet OMZL::clipboard.zsh
zi snippet OMZL::termsupport.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::history.zsh

zinit snippet OMZL::clipboard.zsh
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
