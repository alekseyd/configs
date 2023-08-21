# Specify the preferences directory
script_dir=$(cd "$(dirname "$0")" && pwd)
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${script_dir}"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
