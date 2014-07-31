
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export MANPATH=`manpath`
LINUXENVMAN="$HOME/LINUXENV/usr/share/man"
export MANPATH=$LINUXENVMAN:$MANPATH

# setup locale correctly
[  -z "$LC_ALL" ] && export LC_ALL=en_US.UTF-8
[  -z "$LANG" ] && export LANG=en_US.UTF-8

alias ls='/bin/ls $LS_OPTIONS'
#options for GNU version of ls
export LS_OPTIONS="--classify --literal --color --tabsize 0"
#if it's not GNU, switch to POSIX options
ls >/dev/null 2>&1 || export LS_OPTIONS='-FG'

alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -la'

alias lc='ls -l --color=no'
#if it's not GNU, switch to POSIX options
lc >/dev/null 2>&1 || alias lc='env ls -l -F'

export PS1="\u@\h:\w>"

function sgrep () 
{
    find . -name "*.[ch]pp" | xargs grep -n "$@"
    find . -name "*.[ch]" | xargs grep -n "$@"
}
function pgrep () 
{
    find . -name "*.py" | xargs grep -n "$@"
}

alias cd..='cd ..'
alias cd.='cd .'
alias cd...='cd ../..'

function git_parse_branch() 
{
    name=`git branch 2>/dev/null | grep "^\*" | tr -d "\*\ "`
    [[ -z $name ]] || echo \[$name\]
}

# MacPorts Bash shell command completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
# Homebrew Bash shell command completion
    . $(brew --prefix)/etc/bash_completion
elif [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
# Homebrew bash-completion2:
    . $(brew --prefix)/share/bash-completion/bash_completion
fi

case "$TERM" in
    screen|xterm-color|xterm|xterm-256color)
        normal="\[\e[00m\]"
        bold="\[\e[01m\]"
        green="\[\e[00;32m\]"
        magenta="\[\e[00;36m\]"
        purple="\[\e[00;35m\]"
        darkgrey="\[\e[01;30m\]"
        export PS1="${green}\u${bold}@${normal}MACBOOK${bold}:${purple}\w${darkgrey}\$(git_parse_branch)${normal}> "
        unset normal bold green magenta purple darkgrey
        # reload .history and set the title to user@host:dir
        PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~} ($(git_parse_branch))\007"'
    ;;
esac


function rmb {
  current_branch=$(git branch --no-color 2> /dev/null | sed -E -e '/^[^*]/d' -e 's/[*] *([^ ]*).*/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
    return 1
  fi
    echo "Fetching merged branches..."
  git remote prune origin
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\\//:/g' | tr -d '\\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\\///g' | tr -d '\\n'`
    else
      echo "No branches removed."
    fi
  fi
}

#Calculate actual location of .profile script (after resolving all softlinks)
function resolv_path {
    scritpname=$1
    while [ -h $scritpname ]; do scritpname=`readlink $scritpname`; done
    echo $scritpname
}

#Python fine tuning
RESOLVED_NAME=`resolv_path ${BASH_SOURCE[0]}`
pushd `dirname $RESOLVED_NAME`
source .pythonrc
popd

#Infinidat related stuff
INFINIO=~/git/infinio
alias cdi='cd $INFINIO'
alias cdh='cd $INFINIO/host_src'
##################

