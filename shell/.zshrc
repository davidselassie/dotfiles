# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="selassid"
DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
ZSH_CUSTOM="$HOME/.zshcustom"
plugins=(osx brew tmux)

source "$ZSH/oh-my-zsh.sh"

# User configuration

export EDITOR="atom -w"
export VISUAL="$EDITOR"

if [[ $(ls --version 2> /dev/null) == *GNU* ]]; then
    alias ls="ls -lhG --color=auto"
    function lss {
        ls -lhG --color $@ | less -nFRX
    }
else
    alias ls="ls -lhHG"
    function lss {
        CLICOLOR_FORCE=1 ls -lhHG $@ | less -nFRX
    }
fi
if [[ $(sed --version 2> /dev/null) == *GNU* ]]; then
    alias sed="sed -r"
else
    alias sed="sed -E"
fi
if [[ ! $(top --version 2> /dev/null) == *procps* ]]; then
    alias top="top -o cpu"
fi
alias grep="grep -iEn"
alias j="jobs"
alias cp="cp -av"
alias rsync="rsync -avz"
alias frsync="rsync -av -e 'ssh -c arcfour -o Compression=no -x'"
alias rm="rm -iv"
alias du="du -hs"
alias jcat="jq -s -S 'reduce .[] as \$x ({}; . * \$x)'"
alias git-archive='git archive -o "$(basename $PWD)-$(git rev-parse HEAD).tar.bz2" HEAD'

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

if [[ -f "$HOME/.zshrclocal" ]]; then
    source "$HOME/.zshrclocal"
fi
