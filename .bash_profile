ulimit -c unlimited

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

#export MANPATH=`manpath`
#LINUXENVMAN="$HOME/LINUXENV/usr/share/man"
#export MANPATH=$LINUXENVMAN:$MANPATH

# setup locale correctly
[  -z "$LC_ALL" ] && export LC_ALL=en_US.UTF-8
[  -z "$LANG" ] && export LANG=en_US.UTF-8


# MacPorts Bash shell command completion
uname -svr | grep "Darwin" >/dev/null 2>&1
if [ -z "$?" ]; then
    if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    else 
        type brew 2>/dev/null 1>/dev/null
        if [ $? -eq "0" ]; then
            if [ -f $(brew --prefix)/etc/bash_completion ]; then
            # Homebrew Bash shell command completion
                . $(brew --prefix)/etc/bash_completion
            elif [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
            # Homebrew bash-completion2:
                . $(brew --prefix)/share/bash-completion/bash_completion
            fi
        fi
    fi
fi

export PS1="\u@\h:\w>"
case "$TERM" in
    screen|xterm-color|xterm|xterm-256color|cygwin|putty|putty-256color)
        function git_parse_branch()
        {
            name=`git branch 2>/dev/null | grep "^\*" | tr -d "\*\ "`
            [[ -z $name ]] || echo \[$name\]
        }
        normal="\[\e[00m\]"
        bold="\[\e[01m\]"
        green="\[\e[00;32m\]"
        magenta="\[\e[00;36m\]"
        purple="\[\e[00;35m\]"
        darkgrey="\[\e[01;30m\]"
        HOSTNAME=$(hostname -s)
        export PS1="${green}\u${bold}@${normal}${HOSTNAME}${bold}:${purple}\w${darkgrey}\$(git_parse_branch)${normal}> "
        unset normal bold green magenta purple darkgrey
        # reload .history and set the title to user@host:dir
        PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~} ($(git_parse_branch))\007"'
    ;;
esac

#JETHRODATA related stuff
export LD_LIBRARY_PATH="/usr/local/lib:/usr/java/latest/jre/lib/amd64/server:/usr/lib/impala/lib/"
export JETHRO_HOME=~/opt/jethro/current

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

