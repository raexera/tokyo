ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_ENABLE_SECONDARY=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM="symbol"

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
ZSH_THEME_GIT_PROMPT_TAGS_PREFIX=" · 🏷 "

RPROMPT=''
PROMPT=$'┏╸'
[ -n "$SSH_CLIENT" ] \
    && [ -n "$SSH_TTY" ] \
    && PROMPT+='%B%F{blue}@%m%f%b · '  # Hostname, if in SSH session
PROMPT+='%B%30<..<%~%b%<<'             # Path truncated to 30 characters
PROMPT+='%(12V. · %F{244} %12v%f.)'   # Python virtualenv name
PROMPT+='$(gitprompt)'                 # Git status
PROMPT+='$(gitprompt_secondary)'       # Git status secondary info
PROMPT+=$'\n┗╸'                        # Newline

_WPROMPT_END='%(?.%(!.%F{white}❯%F{yellow}❯%F{red}.%F{blue}❯%F{cyan}❯%F{green})❯%f.%F{red}❯❯❯%f) '
# Vi mode indicator, if github.com/woefe/vi-mode.zsh is loaded
if (( $+functions[vi_mode_status] )); then
    VI_INSERT_MODE_INDICATOR=$_WPROMPT_END
    VI_NORMAL_MODE_INDICATOR=${_WPROMPT_END//❯/•}

    PROMPT+='$(vi_mode_status)'
else
    PROMPT+=$_WPROMPT_END
fi


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
