#!/bin/bash

# David Selassie
# bashrc

# Don't load on non interactive instances.
[[ $- != *i* ]] && return
# Load tmux on first pass, then continue on second.
[[ -z $TMUX ]] && exec tmux -2 attach
# Reattach to user OS X namespace on first pass, then continue on second.
[[ -n $(which reattach-to-user-namespace) && -z $REATTACHED ]] && REATTACHED=1 exec reattach-to-user-namespace -l bash

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

[[ -s "$HOME/.hashcolor" ]] && source "$HOME/.hashcolor"
GREEN="\[\033[0;32m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"

function git-prompt {
    # Remember, || is command level.
    REF=$(git symbolic-ref HEAD 2> /dev/null) || REF=$(git rev-parse HEAD 2> /dev/null) || return
    STATUS=$(git status 2> /dev/null)
    if [[ $STATUS =~ "to be committed" ]]; then
        STAGED="${GREEN}S"
    fi
    if [[ $STATUS =~ "not staged" ]]; then
        UNSTAGED="${RED}U"
    fi

    echo "(${C3}${REF#refs/heads/}${STAGED}${UNSTAGED}${NC})"
}
function screen-prompt {
    if [[ ${WINDOW} ]]; then
        echo ",${WINDOW}"
    fi
}
function make-prompt {
    # Append to history file after every prompt.
    history -a
    PS1="${C1}\h${NC}$(screen-prompt):${C2}\w${NC}$(git-prompt)\$ "
}

PROMPT_COMMAND="make-prompt"
# Shows only the last three path components.
PROMPT_DIRTRIM=3

shopt -s histappend
HISTCONTROL=ignoreboth
HISTFILESIZE=1000000
HISTSIZE=1000000

HOMEROOT="$HOME/.local"
export GOROOT="$HOMEROOT/go"
export PLAN9="$HOMEROOT/plan9"
export PATH="$HOMEROOT/bin:$HOMEROOT/binlocal:/usr/local/bin:$PATH:/usr/local/heroku/bin:$GOROOT/bin:$PLAN9/bin"
export MANPATH="$HOMEROOT/man:$MANPATH"

export ALTERNATE_EDITOR="" # This will start a daemon emacs if not already running.
# Emacsclient work inside of emacs if you do not force TTY start.
if [[ -n $INSIDE_EMACS ]]; then
    alias em="emacsclient"
    export EDITOR="emacsclient"
    export VISUAL="emacsclient"
else
    alias em="emacsclient -t"
    export EDITOR="emacsclient -t"
    export VISUAL="emacsclient -t"
fi

if [[ $(uname) == "Darwin" ]]; then
    export LSCOLORS="exgxfxdxcxegedabagacad"
    alias ls="ls -lhHG"
    alias sed="sed -E"
    function lss {
        CLICOLOR_FORCE=1 ls -lhHG $@ | less -nFRX
    }
    alias top="top -o cpu"
else
    alias ls="ls -lhG --color=auto"
    alias sed="sed -r"
    function lss {
        ls -lhG --color $@ | less -nFRX
    }
fi

alias grep="grep -iEn"
function sg {
    # Remember that aliases don't get expanded in scripts.
    find . -type fl | xargs grep -in "$*"
}
alias j="jobs"
alias cp="cp -av"
alias rsync="rsync -avz"
alias frsync="rsync -av -e 'ssh -c arcfour -o Compression=no -x'"
alias rm="rm -iv"
alias du="du -hs"
# Can use "cd -" to uncd.
alias git-archive='git archive -o "$(basename $PWD)-$(git rev-parse HEAD).tar.bz2" HEAD'
function git-kill-branch {
    git fetch
    git branch -d $1
    git push origin --delete $1
}
function md {
    mkdir "$1"
    cd "$1"
}

function mid {
    tail -n +$1 $3 | head -n $2
}

function runin {
    if (( $# < 2 )); then
        echo 'USAGE: runin CMD DIRS...' 1>&2
        echo 'Variable $D will store current directory name.' 1>&2
        return 1
    fi

    TODO="$1"
    shift
    LIST=$@
    BASED="$PWD"

    for D in $LIST
    do
        if [ -d "$D" ]
        then
            echo "Running in '$D'..." 1>&2
            cd "$D"
            eval "$TODO"
            cd "$BASED"
            echo '...done.' 1>&2
        else
            echo "runin: '$D' isn't a directory." 1>&2
        fi
    done
}

# Marks your CWD then lets you return to it from anywhere with back.
function mark {
    MARK="$PWD"
}
function back {
    LAST="$PWD"
    cd "$MARK"
    MARK="$LAST"
}

[[ -s "$HOME/.bashlocalrc" ]] && source "$HOME/.bashlocalrc"
