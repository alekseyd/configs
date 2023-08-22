# Set hostname to show with `hostname -s`
scutil --set HostName

# Install go completions
if type go 2>/dev/null >&2; then
    go install github.com/posener/complete/gocomplete@latest
    $(go env GOPATH)/bin/gocomplete -y -install
fi

# iTerm2 setup
#Load prepared iTerm configuration

preference_dir=$(cd "$(dirname "$0")" && pwd)
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${preference_dir}"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

#Download bash integration scripts
curl -L https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
