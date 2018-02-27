export HOMEROOT="$HOME/.local"

typeset -U path  # Make the path array only have unique items.
path=($HOMEROOT/bin /usr/local/bin /usr/local/sbin $path /usr/local/opt/coreutils/libexec/gnubin)

typeset -U manpath
manpath=($HOMEROOT/man /usr/local/opt/coreutils/libexec/gnuman $manpath)

export -TU PKG_CONFIG_PATH pkg_config_path  # Make unique and "tie" the array var to the env var.
pkg_config_path=($HOMEROOT/lib/pkgconfig)

if [[ -f "$HOME/.zprofilelocal" ]]; then
    source "$HOME/.zprofilelocal"
fi
