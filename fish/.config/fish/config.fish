set -x HOMEROOT $HOME/.local
set -x PATH $HOMEROOT/bin /usr/local/bin (cat /etc/paths) /usr/local/opt/coreutils/libexec/gnubin
set -x MANPATH $HOMEROOT/man (cat /etc/manpaths) /usr/local/opt/coreutils/libexec/gnuman
set -x PKG_CONFIG_PATH $HOMEROOT/lib/pkgconfig

set -x EDITOR "atom -nw"
set -x VISUAL $EDITOR

set -x MLR_CSV_DEFAULT_RS lf

set -x GPG_TTY (tty)

if test -e $HOME/.config/fish/configlocal.fish
    source $HOME/.config/fish/configlocal.fish
end
