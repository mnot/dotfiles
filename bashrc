
umask 022 # can be overridden locally

OS=`uname`
if [ -f ${HOME}/.bashrc-${OS} ]; then
	source ${HOME}/.bashrc-${OS};
fi

if [ -f ${HOME}/.bashrc-local ]; then
	source $HOME/.bashrc-local
fi

export VISUAL=nano
export EDITOR=$VISUAL
export PYTHONSTARTUP=$HOME/.pythonrc
export COLORFGBG="white;black"
export LESS="-x4"
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

unset http_proxy
unset ftp_proxy

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

HOSTNAME=`hostname | cut -d "." -f 1`
PS1="$HOSTNAME:\w> "
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*} ${PWD/$HOME/~} $(parse_git_branch) \007"'

### completion
if [ -f /usr/local/etc/bash_completion ] ; then
        # Source completion code
        . /usr/local/etc/bash_completion  2>/dev/null;
elif [ -f ~/.ssh/known_hosts ] ; then
    SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | \
                 cut -f 1 -d ' ' | \
                 sed -e s/,.*//g | \
                 uniq ) )
    complete -o default -W "${SSH_COMPLETE[*]}" ssh;
    complete -o default -W "${SSH_COMPLETE[*]}" scp;
fi


### special cases when we're root
if [ `/usr/bin/id -u` = 0 ]; then
	PS1="$HOSTNAME:\w# "
	export PATH=$SPATH:$PATH
	umask 022
fi

set -P		# don't resolve symlinks in paths
ulimit -c 0	# don't drop core dumps

### alises
alias which="type -path"
alias f=finger
alias ls="ls -F"
