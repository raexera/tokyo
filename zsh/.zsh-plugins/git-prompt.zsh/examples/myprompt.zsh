ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_ENABLE_SECONDARY=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"

ZSH_THEME_GIT_PROMPT_PREFIX=" · "
ZSH_THEME_GIT_PROMPT_SUFFIX="›"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" ‹"
ZSH_THEME_GIT_PROMPT_BRANCH="⎇ %{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_DETACHED="@%{$fg_no_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[blue]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[blue]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

PROMPT=$'%F{152}%(4~| /%3~|%~)%f %F{242}$(gitprompt)%f
%(12V.%F{242}%12v%f .)%(?.%F{magenta}.%F{red})❯%f '
RPROMPT=''

setup() {
    [[ -n $_PROMPT_INITIALIZED ]] && return
    _PROMPT_INITIALIZED=1

    # Prevent Python virtualenv from modifying the prompt
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    # Set $psvar[12] to the current Python virtualenv
    function _prompt_update_venv() {
        psvar[12]=
        if [[ -n $VIRTUAL_ENV ]] && [[ -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
            psvar[12]="${VIRTUAL_ENV:t}"
        fi
    }
    add-zsh-hook precmd _prompt_update_venv

    # Draw a newline between every prompt
    function _prompt_newline(){
        if [[ -z "$_PROMPT_NEWLINE" ]]; then
            _PROMPT_NEWLINE=1
        elif [[ -n "$_PROMPT_NEWLINE" ]]; then
            echo
        fi
    }
    add-zsh-hook precmd _prompt_newline

    # To avoid glitching with fzf's alt+c binding we override the fzf-redraw-prompt widget.
    # The widget by default reruns all precmd hooks, which prints the newline again.
    # We therefore run all precmd hooks except _prompt_newline.
    function fzf-redraw-prompt() {
        local precmd
        for precmd in ${precmd_functions:#_prompt_newline}; do
            $precmd
        done
        zle reset-prompt
    }
}
setup
