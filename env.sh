
# setup locale correctly
[  -z "$LC_ALL" ] && export LC_ALL=en_US.UTF-8
[  -z "$LANG" ] && export LANG=en_US.UTF-8


# Adding go to path
#if type go 2>/dev/null >&2; then
#    export PATH=$(go env GOPATH)/bin:$PATH
#fi

