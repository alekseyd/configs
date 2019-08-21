ulimit -c unlimited

#export PATH="/usr/local/bin:$PATH"
#export PATH="/usr/local/sbin:$PATH"

#export MANPATH=`manpath`
#LINUXENVMAN="$HOME/LINUXENV/usr/share/man"
#export MANPATH=$LINUXENVMAN:$MANPATH

# setup locale correctly
[  -z "$LC_ALL" ] && export LC_ALL=en_US.UTF-8
[  -z "$LANG" ] && export LANG=en_US.UTF-8


# HomeBrew bash shell command completion
if uname -svr | grep "Darwin" >/dev/null 2>&1; then
    if type brew 2>/dev/null >&2; then
        if [ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
        # Homebrew bash-completion@2:
            export BASH_COMPLETION_COMPAT_DIR=$(brew --prefix)/etc/bash_completion.d
            # you can set:
            # * $BASH_COMPLETION_USER_DIR(defaulted to: $HOME/.local/share/bash-completion/)
            #   and put your completions into ${BASH_COMPLETION_USER_DIR}/completions
            # * or $BASH_COMPLETION_USER_FILE (defaulted to: ~/.bash_completion)
            . $(brew --prefix)/etc/profile.d/bash_completion.sh
        fi
    fi
fi

# Go completion
if type brew 2>/dev/null >&2; then
    complete -C $(go env GOPATH)/bin/gocomplete go
fi

RESOLVED_PATH=`grealpath ${BASH_SOURCE[0]}`
CONFIG_LOCATION="$(dirname $RESOLVED_PATH)"
#Python/virtualenv fine tuning
type pip2 2>/dev/null 1>&2
if [ $? -eq 0 ]; then
    pushd $CONFIG_LOCATION >/dev/null
    source .pyrc
    popd >/dev/null
    eval "$(pip2 completion --bash 2>/dev/null)"
fi
type pip 2>/dev/null 1>&2
if [ $? -eq 0 ]; then
    eval "$(pip completion --bash 2>/dev/null)"
fi
unset RESOLVED_PATH CONFIG_LOCATION

#AWS cmdline complete
complete -C "$(which aws_completer)" aws

#OCI cmdline complete
OCI_AUTOCOMPLETE=~/lib/oracle-cli/lib/python3.7/site-packages/oci_cli/bin/oci_autocomplete.sh
[[ -r "$OCI_AUTOCOMPLETE" ]] && . "$OCI_AUTOCOMPLETE"

PS1="\u@\h:\w>"
case "$TERM" in
    screen|xterm-color|xterm|xterm-256color|cygwin|putty|putty-256color)
        function git_parse_branch()
        {
            name=`git branch 2>/dev/null | grep "^\*" | tr -d "\*\ "`
            [[ -z "$name" ]] || echo \[$name\]
        }
        normal="\[\e[00m\]"
        bold="\[\e[01m\]"
        green="\[\e[00;32m\]"
        magenta="\[\e[00;36m\]"
        purple="\[\e[00;35m\]"
        darkgrey="\[\e[01;30m\]"
        yellow="\[\e[01;33m\]"
        #Colors from:
        #  http://www.pantone.com/color-of-the-year-2017
        BlueRadiance="\[\e[38;2;89;201;213m"
        Sheepskin="\[\e[38;2;219;181;144m"
        OrangePopsicle="\[\e[38;2;247;121;36m"
        PinkIcing="\[\e[38;2;236;161;166m"
        Marsala="\[\e[38;2;150;79;76m"
        TangerineTango="\[\e[38;2;225;82;61m"
        FlameOrange="\[\e[38;2;255;166;79m"
        Orange="\[\e[38;2;255;109;00m"
        HOSTNAME=$(hostname -s)
        PS1="${green}\u${bold}@${normal}${HOSTNAME}${bold}:${purple}\w${yellow}\$(git_parse_branch)${normal}> "
        #export PS1="${green}\u${bold}@${normal}${HOSTNAME}${bold}:${purple}\w${yellow}\${GIT_BRANCH}${normal}> "
        unset normal bold green magenta purple darkgrey yellow
    ;;
esac

# Whenever displaying the prompt, write the previous line to disk
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#PROMPT_COMMAND="GIT_BRANCH=\$(git_parse_branch); $PROMPT_COMMAND"

# Set unlimited history, but keep only 3000 last commands  on disk
HISTFILESIZE=3000
HISTSIZE=
HISTTIMEFORMAT="[%F %T] "

# If set, a command name that is the name of a directory is executed as if it were the argument to the cd command.
# This option is only used by interactive shells.
shopt -s autocd
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell
# bash attempts spelling correction on directory names during word completion if the directory 
# name initially supplied does not exist.
shopt -s dirspell


# If set, bash checks that a command found in the hash table exists before trying to execute it.
# If a hashed command no longer exists, a normal path search is performed.
shopt -s checkhash

# If set, the pattern ** used in a pathname expansion context will match all files and zero or more directories and subdirectories.
# If the pattern is followed by a /, only directories and subdirectories match.
shopt -s globstar

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# If set, and readline is being used, a user is given the opportunity to re-edit a failed history substitution.
shopt -s histreedit
# If set, and readline is being used, the results of history substitution are not immediately passed to the shell parser.  Instead, the resulting line is loaded into the readline editing buffer, allowing  further  modifica- tion.
shopt -s histverify

# bash replaces directory names with the results of word expansion when performing filename completion.  
# This changes the contents of the readline editing buffer.  If not set, bash attempts to preserve what the user typed.
# (introduced since bash 4.2)
# ** NOT USEFUL **
#shopt  -s direxpand 2>/dev/null

#iTerm2 integration on Mac
[[ -r "${HOME}/.iterm2_shell_integration.bash" ]]   && . "${HOME}/.iterm2_shell_integration.bash"

# Get the aliases and functions
# (file exists and is readable)
[[ -r ~/.bashrc ]] && . ~/.bashrc

export PATH=/Users/aleksey.dashevsky/bin:$PATH
if type go 2>/dev/null >&2; then
    export PATH=$(go env GOPATH)/bin:$PATH
fi
