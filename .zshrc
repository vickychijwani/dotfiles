setopt completealiases

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# for fancy unicode characters in the prompt
export LC_CTYPE='en_US.UTF-8'

# prompt theme
ZSH_THEME="vicky"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow task-warrior extract gem pip rvm archlinux lein npm dircycle pass)

source $ZSH/oh-my-zsh.sh

# syntax highlighting pager
$ () {
    /usr/share/vim/vim73/macros/less.sh "$*"
}

# aliases
source ~/.zsh_aliases

# z: super-fast directory jumping
source ~/.z.sh

# environment variables
export RSENSE_HOME=/opt/rsense-0.3
export PYTHONSTARTUP=~/.pythonrc
export CC="colorgcc"
export EDITOR="emacsclient -a '' -c"
export TERM=xterm-256color
export NODE_PATH=/usr/local/lib/node_modules

# export http_proxy=http://144.16.192.218:8080/
# export https_proxy=https://144.16.192.218:8080/
# export HTTP_PROXY=http://144.16.192.218:8080/
# export HTTPS_PROXY=https://144.16.192.218:8080/

# list all tasks
export TODOTXT_DEFAULT_ACTION=ls
echo
t

# colored man pages
man() {
        env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
