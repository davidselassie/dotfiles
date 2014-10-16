#!/bin/bash
# This gets executed on all login shells.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ $(which pyenv) ]] && eval "$(pyenv init -)"

export HOMEROOT="$HOME/.local"
export PATH="$HOMEROOT/bin:$HOME/.dotfiles/bin:/usr/local/bin:$PATH:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/heroku/bin:$GOROOT/bin"
export MANPATH="$HOMEROOT/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PKG_CONFIG_PATH="$HOMEROOT/lib/pkgconfig"

export ALTERNATE_EDITOR="" # This will start a daemon emacs if not already running.
# When emacs is invoked from a convenience command, don't use -n to wait.
export EDITOR="$(which emacsclient)"
export VISUAL="$EDITOR"

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
