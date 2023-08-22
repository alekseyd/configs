
# HomeBrew bash shell command completion
if uname -svr | grep -q "Darwin" 2>/dev/null; then
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

# For Go completion use module
# https://pkg.go.dev/github.com/posener/complete
if type go 2>/dev/null >&2; then
    : # NOOP
fi


#Python completion
for PIP in pip pip3; do
    type $PIP 2>/dev/null 1>&2
    if [ $? -eq 0 ]; then
        eval "$($PIP completion --bash 2>/dev/null)"
    fi
done
unset PIP
