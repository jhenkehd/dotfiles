# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=2000
setopt appendhistory extendedglob nomatch notify
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
# Gentoo default prompt
# this is the sequence used by Gentoo, define here explicitly, so it works on
# non-Gentoo systems too, use conditional for root %(# . . )
PROMPT="%(#.%B%F{red}%m%k %B%F{blue}%1~ %# %b%f%k.%B%F{green}%n@%m%k %B%F{blue}%1~ %# %b%f%k)"

# Load customer completions
if [[ -a ~/.zsh/completion ]]; then
    fpath=(~/.zsh/completion $fpath)
fi

zstyle ':completion:*' special-dirs true # complete .. as parent directory
zstyle ':completion::complete:*' use-cache 1
#zstyle ':completion:*' hosts off
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt correct hist_ignore_all_dups hist_ignore_space
# to disable autocorrection use: unsetopt correct
# but for now we just whitelist common annoying correction suggestions
alias vim='nocorrect vim'

# setup prompt
GIT_PROMPT_SOURCE=~/.zsh/git-prompt/zshrc.sh

if [[ -a $GIT_PROMPT_SOURCE ]]; then
    source $GIT_PROMPT_SOURCE
    function zle-line-init zle-keymap-select {
        VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
        RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(git_super_status) $EPS1"
        zle reset-prompt
    }
else
    function zle-line-init zle-keymap-select {
        VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
        RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
        zle reset-prompt
    }
fi
#unset $GIT_PROMPT_SOURCE

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# print current working directory to terminal title
precmd() {
    print -Pn "\e]0;%n@%m:%~\a"
}

# in new terminal (tabs), make sure to change to the previous working directory
. /etc/profile.d/vte-2.91.sh

# Use vim cli mode
bindkey '^p' up-history
bindkey '^n' down-history
# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
# ctrl-w removed word backwards
bindkey '^w' backward-kill-word
# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward
# alt-. inserts last word from previous command
bindkey '\e.' insert-last-word
# delete from cursor to beginning of line
bindkey '^u' backward-kill-line
# delete from cursor to end of line
bindkey '^k' kill-line
# delete next word
bindkey '^[d' kill-word
# uppercase word starting from cursor
bindkey '^[u' up-case-word
# go to beginning of line (^A is used by tmux)
bindkey '^b' beginning-of-line
# go to end of line
bindkey '^e' end-of-line

bindkey "^[OH"  beginning-of-line # Home
bindkey "^[[2~" overwrite-mode    # Ins
bindkey "^[[3~" delete-char       # Delete
bindkey "^[OF"  end-of-line       # End

# Move back/forward one word with CTRL+arrow key
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

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

# Allgemeine Aliase für häufig genutzte Anwendungen
alias cpa='cp -a'
alias batterystatus='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

# Gentoo Aliase
alias grubconfig='grub-mkconfig -o /boot/grub/grub.cfg'
alias emerge-update='emerge --oneshot --ask --deep --newuse --update --keep-going --with-bdeps=y @world'

# Gitk Aliase
alias gitka="gitk --all"
alias gitkm="gitk --branches=\*master\* --remotes=\*/\*master\*"

## Exports
# non-root exports
if [[ $UID != 0 || $EUID != 0 ]]; then
	export ASM=clang
	export CC=clang
	export CXX=clang++

	export GPGKEY=1F6B23CE

	export DEBFULLNAME="Jan Henke"
	export DEBEMAIL=jhenke@hugendubel-digital.de

	export SSLKEYLOGFILE=$HOME/.tlslogs/tlskeylog.log
fi

export EDITOR=/usr/bin/vim
export PATH=$HOME/.local/bin:/opt/bin:$PATH
export TNS_ADMIN=/home/jhenke/TnsAdmin
export INSTANTCLIENT=$TNS_ADMIN/instantclient_12_1
