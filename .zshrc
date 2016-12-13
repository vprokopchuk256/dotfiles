if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

stty -ixon

# Path to your oh-my-zsh installation.
export ZSH=/Users/vprokopchuk/.oh-my-zsh
export EDITOR='vim'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="solarized-powerline"
ZSH_POWERLINE_SHOW_USER=false
ZSH_POWERLINE_SHOW_IP=false
ZSH_POWERLINE_SINGLE_LINE=false
ZSH_POWERLINE_SHOW_OS=true
ZSH_POWERLINE_SHOW_RETURN_CODE=false
ZSH_POWERLINE_SHOW_TIME=true
plugins=(git)

# User configuration

export PATH="/Users/vprokopchuk/.rbenv/shims:/Users/vprokopchuk/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Users/vprokopchuk/.rbenv/shims:/Users/vprokopchuk/.rbenv/bin:/Users/vprokopchuk/.rvm/bin"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

source $ZSH/oh-my-zsh.sh
source ~/.zsh/antigen.zsh

antigen bundle Tarrasch/zsh-autoenv
antigen bundle zsh-users/zsh-syntax-highlighting

source ~/.zsh/zsh-history-substring-search.zsh

RPROMPT='%(1j.%j.)'

function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
  esac

  zle reset-prompt
  zle -R
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
 }

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle-line-init() { zle -K vicmd; }
zle -N zle-line-init
zle -N fancy-ctrl-z
zle -N edit_in_place

bindkey -M vicmd '^Z' fancy-ctrl-z

bindkey -v

bindkey jj vi-cmd-mode
bindkey -M vicmd v edit-command-line
setopt interactivecomments
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line
bindkey -M vicmd ',f' history-incremental-pattern-search-backward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
