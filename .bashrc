# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Expand History Substitutions inline as the space key is pressed
# try typing "!1<Space>" and see it magically expand to your last typed command
bind Space:magic-space

# set to "yes" for a colored prompt, if the terminal has the capability
force_color_prompt=yes

# -------------------------

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ "$force_color_prompt" = yes ]; then
    # PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[00m\] \[\033[01;32m\]\w\[\033[00m\]$(__git_ps1 " \[\033[01;35m\](%s)\[\033[00m\]")\n\[\033[01;34m\]\$\[\033[00m\] '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

source ~/.bash_profile

# work-around for bug introduced by a recent update in bash-completion
# removes the error: "__git_ps1: command not found"
# see https://mailman.archlinux.org/pipermail/arch-general/2012-March/025886.html
source /etc/bash_completion.d/git

parse_git_dirty () {
    [[ $(__git_ps1) != "" ]] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

print_pre_prompt () {
    # the first part of the prompt, i.e., the user's name
    local PS1U=$USER

    # the second part of the prompt, i.e., the present working directory
    local PS1WD="${PWD}"
    [[ $PS1WD = "$HOME" ]] && PS1WD=\~
    [[ $PS1WD = *"$HOME"/* ]] && PS1WD=\~${PS1WD#$HOME}

    # the fourth and last part of the prompt, i.e., the git stuff
    local git_dirty=$(parse_git_dirty)
    local git_dirty_color="\033[1;31m"
    local git_clean_color="\033[1;30m"
    [[ $git_dirty = "*" ]] && local git_color=$git_dirty_color || local git_color=$git_clean_color
    local PS1R=`__git_ps1 "%s"`$git_dirty

    # the third part of the prompt, i.e., the separator consisting of hyphens
    local PS1SEP=""
    while [ $(echo ${#PS1U}+${#PS1SEP}+${#PS1WD}+${#PS1R}+3 | bc) -lt $COLUMNS ]; do
        PS1SEP=$PS1SEP-
    done

    # putting it all together
    printf "\n\033[1;32m%s \033[1;34m%s \033[0;36m%s $git_color%s" "$PS1U" "$PS1WD" "$PS1SEP" "$PS1R"
}

PROMPT_COMMAND=print_pre_prompt

# syntax highlighting pager
_ () {
    /usr/share/vim/vim73/macros/less.sh "$*"
}

# set $PATH
PATH=$PATH:/usr/bin/vendor_perl:$HOME/.rvm/bin # Add RVM to PATH for scripting
