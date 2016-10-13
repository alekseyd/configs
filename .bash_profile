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
#        function git_parse_branch()
#        {
#            name=`git branch 2>/dev/null | grep "^\*" | tr -d "\*\ "`
#            [[ -z "$name" ]] || echo \[$name\]
#        }
        normal="\[\e[00m\]"
        bold="\[\e[01m\]"
        green="\[\e[00;32m\]"
        magenta="\[\e[00;36m\]"
        purple="\[\e[00;35m\]"
        darkgrey="\[\e[01;30m\]"
        HOSTNAME=$(hostname -s)
        export PS1="${green}\u${bold}@${normal}${HOSTNAME}${bold}:${purple}\w${darkgrey}\$(git_parse_branch)${normal}> "
        unset normal bold green magenta purple darkgrey
    ;;
esac

# Whenever displaying the prompt, write the previous line to disk
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Set unlimited history, but keep only 3000 last commands  on disk
export HISTFILESIZE=3000
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# bash replaces directory names with the results of word expansion when performing filename completion.  
# This changes the contents of the readline editing buffer.  If not set, bash attempts to preserve what the user typed.
shopt -s direxpand
# bash attempts spelling correction on directory names during word completion if the directory 
# name initially supplied does not exist.
shopt -s dirspell

#JETHRODATA related stuff
export LD_LIBRARY_PATH="/usr/local/lib:/usr/java/latest/jre/lib/amd64/server:/usr/lib/impala/lib/"
[[ -z "$JETHRO_HOME" ]] && export JETHRO_HOME=~/opt/jethro/current

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

