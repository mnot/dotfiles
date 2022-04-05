#!/bin/bash

umask 022 # can be overridden locally

export LOCAL=/usr/local

OS=$(uname)
if [ -f "${HOME}/.bashrc-${OS}" ]; then
	source "${HOME}/.bashrc-${OS}";
fi

if [ -f "${HOME}/.bashrc-local" ]; then
	source "${HOME}/.bashrc-local"
fi

export VISUAL=nano
export EDITOR=$VISUAL
export PYTHONSTARTUP=$HOME/.pythonrc
export COLORFGBG="white;black"
export LESS="-x4 -R"
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

unset http_proxy
unset ftp_proxy

# colourise man
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

### prompt
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi


### completion
if [ -f "${LOCAL}/etc/bash_completion" ] ; then
        # Source completion code
        . ${LOCAL}/etc/bash_completion  2>/dev/null;
elif [ -f ~/.ssh/known_hosts ] ; then
    SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | \
                 cut -f 1 -d ' ' | \
                 sed -e s/,.*//g | \
                 uniq ) )
    complete -o default -W "${SSH_COMPLETE[*]}" ssh;
    complete -o default -W "${SSH_COMPLETE[*]}" scp;
fi

### lesspipe
if [ -f "${LOCAL}/bin/lesspipe.sh" ] ; then
    LESSOPEN="|${LOCAL}/bin/lesspipe.sh %s";
    export LESSOPEN;
elif [ -f "/usr/bin/lesspipe.sh" ] ; then
    LESSOPEN="|/usr/bin/lesspipe.sh %s";
    export LESSOPEN;
fi

### special cases when we're root
if [ "$(/usr/bin/id -u)" = 0 ]; then
	export PATH=$SPATH:$PATH
	umask 022
fi

set -P		# don't resolve symlinks in paths
ulimit -c 0	# don't drop core dumps

### alises
alias which="type -path"
alias f=finger
alias ls="ls -F"
alias pip3-upgrade="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"