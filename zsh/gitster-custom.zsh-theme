local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

CROSS="\u2718"
TICK="\u2714"

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX$(parse_git_dirty)"
}

function get_pwd(){
    git_root=$PWD
    while [[ $git_root != / && ! -e $git_root/.git ]]; do
        git_root=$git_root:h
    done
    if [[ $git_root = / ]]; then
        unset git_root
        prompt_short_dir=%~
    else
        parent=${git_root%\/*}
        prompt_short_dir=${PWD#$parent/}
    fi

    echo "$prompt_short_dir"
}

PROMPT='$ret_status%{$fg[blue]%}%D{[%X]} %n@%m > %{$fg[green]%}$(get_pwd) $(git_prompt_info)%{$reset_color%}
➜ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}$CROSS"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}$TICK"
