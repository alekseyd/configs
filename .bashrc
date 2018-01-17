# .bashrc

# Source global definitions
if [ -s /etc/bashrc ]; then
    . /etc/bashrc
elif [ -s /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# User specific aliases and functions

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

#If "vim" has been installed -- alias vi to vim
#type vim 2>/dev/null 1>&2 && ! alias vim 2>/dev/null 1>&2 && alias vi=vim
# ***** already done by /etc/profile.d/vi.sh
#export EDITOR=`alias | which -i vi`
export EDITOR=`alias | which -a vi`
export FCEDIT=vim

#Calculate actual location of configuration scripts(after resolving all softlinks)
function resolve_path {
    local scritpname=$1
    RESOLVED_CONFIG_NAME="$(readlink  "$scritpname")"
}

resolve_path ${BASH_SOURCE[0]}
CONFIG_LOCATION="$(dirname "$RESOLVED_CONFIG_NAME")"
unset resolve_path RESOLVED_CONFIG_NAME

#in-file search helpers
function sgrep ()
{
    find . -name "*.[ch]pp" -print0 | xargs -0 grep --color -n "$@"
    find . -name "*.[ch]" -print0 | xargs -0 grep --color -n "$@"
    find . -name "*.[ch]xx" -print0 | xargs -0 grep --color -n "$@"
    find . -name "*.cc" -print0 | xargs -0 grep --color -n "$@"
}

function pgrep ()
{
    find . -name "*.py" -print0 | xargs -0 grep --color -n "$@"
}

type -a pss >/dev/null 2>&1
if [ $? -ne 0 ]; then
    alias pss="PYTHONPATH=$PYTHONPATH:$CONFIG_LOCATION/pss/ $CONFIG_LOCATION/pss/scripts/pss"
fi

alias cd..='cd ..'
alias cd.='cd .'
alias cd...='cd ../..'

function git_parse_branch()
{
    name=`git branch 2>/dev/null | grep "^\*" | tr -d "\*\ "`
    [[ -z $name ]] || echo \[$name\]
}

function svnclean()
{
    svn status --no-ignore | egrep '^[?I]' | cut -c9- | xargs -d \\n rm -r

}

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

#Python/virtualenv fine tuning
type pip2 2>/dev/null 1>&2
if [ $? -eq 0 ]; then
    pushd $CONFIG_LOCATION >/dev/null
    source .pyrc
    popd >/dev/null
fi
