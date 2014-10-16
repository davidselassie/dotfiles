#!/bin/bash
# This is where bash specific, interactive settings go. It will be read
# automatically on non-login interactive startup and manually in profile
# on login interactive startup.

if [[ $TERM != "dumb" ]]; then
    [[ -s "$HOME/.hashcolor" ]] && source "$HOME/.hashcolor"
    GREEN="\[\033[0;32m\]"
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
fi

if [[ $(which brew) && -f $(brew --prefix)/etc/bash_completion ]]; then
    source $(brew --prefix)/etc/bash_completion
fi

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
    if [[ $STATUS =~ "Unmerged paths" ]]; then
        CONFLICT="${YELLOW}C"
    fi

    echo "(${C3}${REF#refs/heads/}${STAGED}${UNSTAGED}${CONFLICT}${NC})"
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

# Make em return immediately if inside of emacs just to spawn buffers.
if [[ $INSIDE_EMACS ]]; then
    alias em="emacsclient -n"
else
    alias em="emacsclient"
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
alias j="jobs"
alias cp="cp -av"
alias rsync="rsync -avz"
alias frsync="rsync -av -e 'ssh -c arcfour -o Compression=no -x'"
alias rm="rm -iv"
alias du="du -hs"
alias jcat="jq -s -S 'reduce .[] as \$x ({}; . * \$x)'"
# Can use "cd -" to uncd.
alias git-archive='git archive -o "$(basename $PWD)-$(git rev-parse HEAD).tar.bz2" HEAD'
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
