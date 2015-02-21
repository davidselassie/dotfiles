autoload -U colors && color
export LSCOLORS="ExGxFxDxCxEgEdAbAgAcAd"

PROMPT='%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(git_prompt_status)%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}D%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}C%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}U%{$reset_color%}"
