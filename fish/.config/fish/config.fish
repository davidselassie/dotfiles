set -x HOMEROOT $HOME/.local
set -x PATH $HOMEROOT/bin /usr/local/bin $PATH /usr/local/opt/coreutils/libexec/gnubin
set -x MANPATH $HOMEROOT/man $MANPATH /usr/local/opt/coreutils/libexec/gnuman
set -x PKG_CONFIG_PATH $HOMEROOT/lib/pkgconfig $PKG_CONFIG_PATH

set -x EDITOR vise
set -x VISUAL $EDITOR

set -x MLR_CSV_DEFAULT_RS lf

if test -e $HOME/.config/fish/configlocal.fish
    source $HOME/.config/fish/configlocal.fish
end
