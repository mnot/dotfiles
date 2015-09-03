
umask 022 # can be overridden locally

OS=`uname`
if [ -f ${HOME}/.bashrc-${OS} ]; then
	source ${HOME}/.bashrc-${OS};
fi

if [ -f ${HOME}/.bashrc-local ]; then
	source ${HOME}/.bashrc-local
fi

source ${HOME}/.bash_prompt

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

if [ -f /etc/hostname ] ; then
  HOSTNAME=`cat /etc/hostname`
else
  HOSTNAME=`hostname | cut -d "." -f 1`
fi
#PS1="$HOSTNAME:\w> "

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

### lesspipe
if [ -f /usr/local/bin/lesspipe.sh ] ; then
    LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; 
    export LESSOPEN;
fi

### special cases when we're root
if [ `/usr/bin/id -u` = 0 ]; then
#	PS1="$HOSTNAME:\w# "
	export PATH=$SPATH:$PATH
	umask 022
fi

set -P		# don't resolve symlinks in paths
ulimit -c 0	# don't drop core dumps

### alises
alias which="type -path"
alias f=finger
alias ls="ls -F"