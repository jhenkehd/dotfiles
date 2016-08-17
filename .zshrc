# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=2000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# zsh Customization
autoload -U promptinit
promptinit
prompt gentoo

source ~/.local/zsh-git-prompt/zshrc.sh
RPROMPT='$(git_super_status)'

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt correctall hist_ignore_all_dups hist_ignore_space

## Alias Definitions
# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# Allgemeine Aliases für häufig genutzte Anwendungen
alias cpa='cp -a'
alias batterystatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

alias gitka="gitk --all"
alias gitke="gitk --branches=\*ebook\* --remotes=\*/\*ebook\*"
alias gitkm="gitk --branches=\*master\* --remotes=\*/\*master\*"

## Exports
export ASM=/usr/bin/clang
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export EDITOR=vim
export GPGKEY=1F6B23CE
export JAVA_HOME=/usr/lib/jvm/oracle-java8-jdk-amd64
export PATH=$HOME/.local/bin:/opt/bin:$PATH
export SSLKEYLOGFILE=~/.tlslogs/tlskeylog.log

export DEBFULLNAME="Jan Henke"
export DEBEMAIL=jhenke@hugendubel-digital.de

export HOSTNAME=JHenke-Laptop
