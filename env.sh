
# setup locale correctly
[  -z "$LC_ALL" ] && export LC_ALL=en_US.UTF-8
[  -z "$LANG" ] && export LANG=en_US.UTF-8


# Enable GOPATH support
#if type go 2>/dev/null >&2; then
#    export PATH=$(go env GOPATH)/bin:$PATH
#fi

#Java env initialization
if which jenv >/dev/null 2>&1; then
  # export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

#Scala env initialization
if which scalaenv >/dev/null 2>&1; then
  # export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(scalaenv init -)"
fi

#Pyenv initialization
if which pyenv >/dev/null 2>&1; then
  # export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

