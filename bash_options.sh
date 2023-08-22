ulimit -c 0 # no core files please
ulimit -n 4096 # no. of open files

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
        unset normal bold green magenta purple darkgrey yellow
    ;;
esac

# Whenever displaying the prompt, write the previous line to disk
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

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

