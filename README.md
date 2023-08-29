Configs project
=======

My Unix/Mac config files

Installation
------------

1. Start with installing brew, the Missing Package Manager for macOS from https://brew.sh/, normally it is done with a one-liner:
    ```bash    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Install from brew the following packages:
    * `bash` and `bash-completions@2` to have modern version of bash and command line completion (macOS sticks with  older `bash` 3.2.57 due to the licensing issues);
    * `git` — recent git package with command line expansions;
    * `trash` — `rm` alternative which moves files to Trash folder instead of removing them from disk volume;
    * `iTerm2` — terminal the way it has to be;
    * `coreutils` – GNU implementations of all basics POSIX utils, like `ls`, `cat`, `more`, `realpath`, etc., with there respective command line completions for bash. immediately available on a system with "g" prefix prepended to the command names, like `gls`, `gless` etc. To make them available with their regular name follow Caveats from `coreutils` formula:
      ```text
      If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
      PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
      ```
3. Specific tools and environments support:
      * `go` — latest **GoLang** implementation and dev environment
         ```shell
           brew install go 
         ```
         to install `go` command line expansions, use https://pkg.go.dev/github.com/posener/complete project:
        ```shell
          go get -u github.com/posener/complete/gocomplete
          go install github.com/posener/complete/gocomplete@latest
          $(go env GOPATH)/bin/gocomplete -y -install
        ```
4. iTerm2 shell integration
    * download integration scripts
    * source them Bash/Zsh config files

5. Setting up user `.bash_profile`:
    ```shell
      eval "$(/opt/homebrew/bin/brew shellenv bash)"
   
      PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
      source ~/github/configs/env.sh 
      source ~/github/configs/bash_options.sh
      source ~/github/configs/bash_completions.sh
      source ~/github/configs/aliases.sh

      complete -C /Users/aleksey/go/bin/gocomplete go
      source ~/.iterm2_shell_integration.bash
    ```
6. To edit nested structures in plist use either:
    * /usr/libexec/PlistBuddy
    * plutil
    * AppleScript (https://discussions.apple.com/thread/4709713)
