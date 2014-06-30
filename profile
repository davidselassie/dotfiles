#!/bin/bash
# This gets executed on all login shells.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

export HOMEROOT="$HOME/.local"
export PATH="$HOMEROOT/bin:$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:/usr/local/heroku/bin:$GOROOT/bin"
export MANPATH="$HOMEROOT/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PKG_CONFIG_PATH="$HOMEROOT/lib/pkgconfig"

export ALTERNATE_EDITOR="" # This will start a daemon emacs if not already running.
# Emacsclient work inside of emacs if you do not force TTY start.
if [[ -n $INSIDE_EMACS ]]; then
    export EDITOR="$(which emacsclient)"
    export VISUAL=$EDITOR
else
    # Hard code the full path to emacsclient since git might run in an environment with a different path.
    export EDITOR="$(which emacsclient) -t"
    export VISUAL=$EDITOR
fi

# Don't load any UI stuff on non interactive instances.
if [[ $- == *i* ]]; then
    # Load tmux on first pass, then continue on second.
    # [[ -z $TMUX ]] && exec tmux attach
    # Reattach to user OS X namespace on first pass, then continue on second.
    # [[ -n $(which reattach-to-user-namespace) && -z $REATTACHED ]] && REATTACHED=1 exec reattach-to-user-namespace -l bash
    # Login shells need to manually read bashrc.
    if [ -r ~/.bashrc ]; then source ~/.bashrc; fi
fi
# Non-login interactive shells automatically read bashrc.

[[ -s "$HOME/.profilelocal" ]] && source "$HOME/.profilelocal"
