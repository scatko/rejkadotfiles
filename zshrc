# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias pd="/Applications/Pd-extended.app/Contents/Resources/bin/pd"
alias pdsend="/Applications/Pd-extended.app/Contents/Resources/bin/pdsend"
alias pdrecieve="/Applications/Pd-extended.app/Contents/Resources/bin/pdrecieve"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby)
plugins+=(zsh-nvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Cyrillic
# export LC_ALL="ru_RU.UTF-8"
export LC_ALL="be_BY.UTF-8"

# GCC
export PATH=~/.gcc/gcc-4.8.1/bin:$PATH

# homebrew
PATH=~/.homebrew/bin:~/.homebrew/share/python:$PATH
export PATH=$PATH:~/.homebrew/bin

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# rbenv
# export PATH="$HOME/.homebrew/Cellar/rbenv/0.4.0/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Postgresapp
# PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
export PGHOST=localhost
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# node modules
export PATH=$PATH:~/.homebrew/share/npm/bin
# export PATH=$PATH:~/.homebrew/share/npm/lib/node_modules/bower/bin
# export PATH=$PATH:~/.homebrew/share/npm/lib/node_modules/grunt-cli/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

# Processing
export PATH=$PATH:~/.processing

# Supercollider
export PATH=$PATH:/Applications/SuperCollider/SuperCollider.app/Contents/Resources

# Vagrant settings quineex
export VAGRANT_MEM=1600
export VAGRANT_CPUS=1
export VAGRANT_CPU_LIMIT=70

# Go lang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Dev

# Android sdk
export ANDROID_HOME=/Users/andy/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

#
# Defines transfer alias and provides easy command line file and folder sharing.
#
# Authors:
#   Remco Verhoef <remco@dutchcoders.io>
#

curl --version 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "Could not find curl."
  return 1
fi

transfer() { 
    # check arguments
    if [ $# -eq 0 ]; 
    then 
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # get temporarily filename, output is written to this file show progress can be showed
    tmpfile=$( mktemp -t transferXXX )
    
    # upload stdin or file
    file=$1

    if tty -s; 
    then 
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        
        if [ -d $file ];
        then
            # zip directory and transfer
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            # transfer file
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else 
        # transfer pipe
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
   
    # cat output link
    cat $tmpfile

    # cleanup
    rm -f $tmpfile
}

