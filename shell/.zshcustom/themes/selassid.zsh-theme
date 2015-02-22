autoload -U colors && colors
export LSCOLORS="ExGxFxDxCxEgEdAbAgAcAd"

function git_prompt() {
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
      echo "(%{$fg_bold[black]%}${ref#refs/heads/}%{$reset_color%}$(git_prompt_status))"
  fi
}

PROMPT='%{$fg_bold[blue]%}%4~%{$reset_color%}$(git_prompt) %{%(?:$reset_color:$fg_bold[red])%}%(2L:^:)%#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}A%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}M%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}D%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}C%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}U%{$reset_color%}"
