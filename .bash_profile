
export PATH=$PATH:~/git/investigate
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt:$PATH"
export PATH="~/git/arcanist/bin:$PATH"

export IOTOOL_BUILD_SERVER="host130.xiv.ibm.com"
export IOTOOL_LOCAL_DIR="/Users/alekseyd/src/iotool/"
export IOTOOL_REMOTE_DIR="/a/home/alekseyd/git/tlib/deps/iotool/"

alias ls='/bin/ls $LS_OPTIONS'
#options for GNU version of ls
export LS_OPTIONS="--classify --literal --color --tabsize 0"
#if it's not GNU, switch to POSIX options
ls >/dev/null 2>&1 || export LS_OPTIONS='-FG'

alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -la'
alias lc='ls -l --color=no'

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

TLIB=~/git/tlib
IOTOOL=$TLIB/iotool
alias cd..='cd ..'
alias cd.='cd .'
alias cd...='cd ../..'
alias cdt='cd $TLIB'
alias cdi='cd $IOTOOL'
alias cdic='cd $IOTOOL/contents/client/'
alias cds='cd $IOTOOL/contents/server/'
alias cdit='cd $IOTOOL/contents/testing/'
alias cdtt='cd ~/git/tests/'
alias cdv='cd ~/git/tests/vaai/'

alias fh='find_sysconf.py host'
alias fs='find_sysconf.py system'

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
#Arcanist bash completion
if [ -f ~/git/arcanist/resources/shell/bash-completion ]; then
    . ~/git/arcanist/resources/shell/bash-completion
fi

case "$TERM" in
    screen|xterm-color|xterm)
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


