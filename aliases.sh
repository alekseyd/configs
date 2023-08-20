
# User specific aliases and functions
alias cd..='cd ..'
alias cd.='cd .'
alias cd...='cd ../..'

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

