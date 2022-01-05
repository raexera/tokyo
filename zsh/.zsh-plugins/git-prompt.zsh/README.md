<h1><img src="screenshot.svg" width="800" /></h1>

A fast, customizable, pure-shell, asynchronous Git prompt for Zsh.
It is heavily inspired by Olivier Verdier's [zsh-git-prompt](https://github.com/olivierverdier/zsh-git-prompt) and very similar to the "Informative VCS" prompt of fish shell.

## Prompt Structure
The structure of the prompt (in the default configuration) is the following:

```
[<branch_name><upstream><tracking_status>|<local_status>]
```

* `branch_name`: Name of the current branch or commit hash if HEAD is detached. When in 'detached HEAD' state, the
    `branch_name` will be prefixed with a colon `:` to indicate that it is actually a hash and not a branch name.
* `upstream`: Name of the remote branch if it exist.
    Must be enabled explicitly (see [Enable remote branch info](#enable-remote-branch-info)).
* `tracking_status`:
    * `↑n`: ahead of remote by `n` commits
    * `↓n`: behind remote by `n` commits
    * `↓m↑n`: branches diverged; other by `m` commits, yours by `n` commits
* `local_status`:
    * `✔`: repository is clean
    * `✖n`: there are `n` unmerged files
    * `●n`: there are `n` staged files
    * `✚n`: there are `n` unstaged and changed files
    * `…n`: there are `n` untracked files
    * `⚑n`: there are `n` entries on the stash (disabled by default)

## Installation
### Dependencies
* Git with `--porcelain=v2` support, which is available since version 2.11.0.
    You can check if your installation is compatible by executing `git status --branch --porcelain=v2` inside a Git repository.
* [awk](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html), which is most certainly preinstalled on any \*nix system

### [Zplug](https://github.com/zplug/zplug)
Either install the default prompt (see [Examples](#examples) section below) with
```
# Installs the "default" example
zplug "woefe/git-prompt.zsh"
```
or choose an example prompt with
```
# Installs the "multiline" example
zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/multiline.zsh}"
```

### [Zplugin](https://github.com/zdharma/zplugin)
```
zplugin ice atload'!_zsh_git_prompt_precmd_hook' lucid
zplugin load woefe/git-prompt.zsh
```
Note that this method does not work if you want to disable the asynchronous rendering.

### Arch Linux
Install [git-prompt.zsh](https://aur.archlinux.org/packages/git-prompt.zsh/) or [git-prompt.zsh-git](https://aur.archlinux.org/packages/git-prompt.zsh-git/) from the AUR. Maintained by [Felixoid](https://github.com/Felixoid).

### FreeBSD
Install the [git-prompt.zsh](https://www.freshports.org/shells/git-prompt.zsh/) package with
```
pkg install git-prompt.zsh
```

### Manual installation
Clone this repo or download the [git-prompt.zsh](https://raw.githubusercontent.com/woefe/zsh-git-prompt/master/git-prompt.zsh) file.
Then source it in your `.zshrc`. For example:

```bash
mkdir -p ~/.zsh
git clone --depth=1 https://github.com/woefe/git-prompt.zsh ~/.zsh/git-prompt.zsh
echo "source ~/.zsh/git-prompt.zsh/git-prompt.zsh" >> .zshrc

# Optional: install an example configuration
echo "source ~/.zsh/git-prompt.zsh/examples/pure.zsh" >> .zshrc
```

## Customization
Unlike other popular prompts this prompt does not use `promptinit`, which gives you the flexibility to build your own prompt from scratch.
You can build a custom prompt by setting the `PROMPT` variable in your `.zshrc` after souring the `git-prompt.zsh`.
And you should use `'$(gitprompt)'` in your `PROMPT` to get the Git prompt.
You must set your `PROMPT` with **single quotes**, not double quotes, otherwise the Git prompt will not update properly.
Some example `PROMPT` configurations are given below.
You can find more information on how to configure the `PROMPT` in [Zsh's online documentation](http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html) or the `zshmisc` manpage, section "SIMPLE PROMPT ESCAPES".

### Examples
You can try these configurations by souring the `.zsh` files from the [examples](./examples) directory.
After you have found a configuration that you like, source it in your `.zshrc`.

#### Default (same as in title)
```zsh
# Preview:
# ../git-prompt.zsh [master↑1|●1✚1…1] ❯❯❯

source examples/default.zsh
```
#### Compact
```zsh
# ../git-prompt.zsh master↑1|●1✚1…1❯

source examples/compact.zsh
```

#### Multi-line prompt
```zsh
# Preview:
# ┏╸130 · ~/workspace/git-prompt.zsh · ⎇ master↑1 ‹●1✚1…1›
# ┗╸❯❯❯

source examples/multiline.zsh
```

#### Git status on the right
```zsh
# Preview:
# ~/workspace/git-prompt.zsh ≻≻≻                                ≺ master↑1|●1✚1…1

source examples/rprompt.zsh
```

#### [Pure](https://github.com/sindresorhus/pure) clone
This clone of the Pure prompt has support for Python virtualenvs, but none of the timing features or a vi mode.
If you are using [fzf](https://github.com/junegunn/fzf), source the example after sourcing fzf's keybindings.
```zsh
# Preview:
#
# ~/workspace/git-prompt.zsh master↑3 ✚2…1
# ❯

source examples/pure.zsh
```
If you want to try other examples again after sourcing the Pure example, you might have to restart your shell, because this prompt will always print a newline between prompts.

#### Woefe's prompt (wprompt)
The wprompt example is similar to the multi-line and Pure examples, but with optional [vi-mode](https://github.com/woefe/vi-mode.zsh) and the secondary prompt enabled.

- Depends on [Font Awesome](https://fontawesome.com/) for the Python symbol
- Optionally depends on [vi-mode](https://github.com/woefe/vi-mode.zsh)
- Source this example after fzf and after loading [vi-mode](https://github.com/woefe/vi-mode.zsh)

```zsh
# Preview:
#
# ┏╸~/workspace/ytcc ·  ytcc · ⎇ master ‹✔›
# ┗╸❯❯❯

source examples/wprompt.zsh
```
If you want to try other examples again after sourcing this example, you might have to restart your shell, because this prompt will always print a newline between prompts.

### Enable secondary prompt
The prompt comes with a secondary function that shows the tags that HEAD points to.
Enabling this will execute another Git command every time a new prompt is shown!
To use the secondary prompt you have to enable it and add the `'gitprompt_secondary'` function to your `PROMPT` or `RPROMPT` variables.
You enable the secondary prompt by adding the following line to your `.zshrc`:

```bash
ZSH_GIT_PROMPT_ENABLE_SECONDARY=1
```

The secondary prompt uses the [label emoji](https://emojipedia.org/label/) by default.
If you encounter problems with the label character, change it (see below) or install a font that can display it, for example [Unifont](https://savannah.gnu.org/projects/unifont) or [twemoji](https://github.com/eosrei/twemoji-color-font).

### Appearance
The appearance of the prompt can be adjusted by changing the variables that start with `ZSH_THEME_GIT_PROMPT_`.
Note that some of them are named differently than in the original Git prompt by Olivier Verdier.

You can preview your configuration by setting the `ZSH_THEME_GIT_PROMPT_*` variables in a running shell.
But remember to save them in your `.zshrc` after you tweaked them to your liking!
Example snippet from `.zshrc`:

```zsh
# Theming variables for primary prompt
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

# Theming variables for the secondary prompt
ZSH_THEME_GIT_PROMPT_SECONDARY_PREFIX=""
ZSH_THEME_GIT_PROMPT_SECONDARY_SUFFIX=""
ZSH_THEME_GIT_PROMPT_TAGS_SEPARATOR=", "
ZSH_THEME_GIT_PROMPT_TAGS_PREFIX="🏷 "
ZSH_THEME_GIT_PROMPT_TAGS_SUFFIX=""
ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[magenta]%}"
source path/to/git-prompt.zsh
```

### Enable remote branch info
The prompt will show information about the remote branch, if `ZSH_GIT_PROMPT_SHOW_UPSTREAM` is set to `full` or `symbol`.
The `full` option will print the full remote branch name enclosed by `ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX` and `ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX`.
The `symbol` option prints only `ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL`.

### Show number of stash entries
The number of stash entries will be shown if `ZSH_GIT_PROMPT_SHOW_STASH` is set.
Enabling this will execute another Git command every time a new prompt is shown!
To enable stash entries add the following line to your `.zshrc`:

```bash
ZSH_GIT_PROMPT_SHOW_STASH=1
```

### Force blank
Since the prompt is asynchronous by default, the Git status updates slightly delayed.
This has the benefit that the prompt will always be responsive even if the repository is huge and/or your disk is slow.
But it also means that the old status will be displayed for some time.
You can force the prompt to blank out instead of displaying a potentially outdated status, but be warned that this will probably increase flickering.
Set the following variable in your `.zshrc` to enable this behavior:

```bash
ZSH_GIT_PROMPT_FORCE_BLANK=1
```

### Disable async
If you are not happy with the asynchronous behavior, you can disable it altogether.
But be warned that this can make your shell painfully slow if you enter large repositories or if your disk is slow.
Set the following variable in your `.zshrc` **before** sourcing the `git-prompt.zsh` to enable this behavior.

```bash
ZSH_GIT_PROMPT_NO_ASYNC=1
```
`ZSH_GIT_PROMPT_NO_ASYNC` cannot be adjusted in a running shell, but only in your `.zshrc`.

### Change the awk implementation
Some awk implementations are faster than others.
By default, the prompt checks for [nawk](https://github.com/onetrueawk/awk) and then [mawk](https://invisible-island.net/mawk/) and then falls back to the system's default awk.
You can override this behavior by setting `ZSH_GIT_PROMPT_AWK_CMD` to the awk implementation of you liking **before** sourcing the `git-prompt.zsh`.
`ZSH_GIT_PROMPT_AWK_CMD` cannot be adjusted in a running shell, but only in your `.zshrc`.

To benchmark an awk implementation you can use the following command.
```bash
# This example tests the default awk. You should change it to something else.
time ZSH_GIT_PROMPT_AWK_CMD=awk zsh -f -c '
    source path/to/git-prompt.zsh
    for i in $(seq 1000); do
        print -P $(_zsh_git_prompt_git_status)
    done'
```

## Features / Non-Features
* A pure shell implementation using [awk](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html); no Python, no Haskell required
    <!-- Well, technically awk is its own programming language and therefore not "pure shell", but heh -->
* Only the Git status.
    This prompt basically only gives you the `gitprompt` function, which you can use to build your own prompt.
    If you are looking for something more complete and blazing fast, I can recommend [powerlevel10k](https://github.com/romkatv/powerlevel10k).
* Uses standard Git, no external Git status daemon (like [gitstatus](https://github.com/romkatv/gitstatus)) required
* Fast; Git command is invoked only once and asynchronously when a new prompt is drawn
* No caching feature, because it breaks reliable detection of untracked files

## Known issues
* If the current working directory is not a Git repository and some external application initializes a new repository in the same directory, the Git prompt will not be shown immediately.
    Also, updates made by external programs or another shell do not show up immediately.
    Executing any command or simply pressing enter will fix the issue.
* In large repositories the prompt might slow down, because Git has to find untracked files.
    See `man git-status`, Section `--untracked-files` for possible options to speed things up.
