autoload -U colors && colors
export LSCOLORS="exgxfxdxcxegedabagacad"

function git_prompt() {
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
      echo "(%{$fg[black]%}${ref#refs/heads/}%{$reset_color%}$(git_prompt_status))"
  fi
}

PROMPT='%{$fg[blue]%}%4~%{$reset_color%}$(git_prompt) %{%(?:$reset_color:$fg[red])%}%(2L:^:)%#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}D%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}C%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}U%{$reset_color%}"
