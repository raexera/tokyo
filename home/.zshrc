# Fetch
afetch

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Ditch Nano, join the NeoVim Team
export EDITOR=/usr/bin/nvim
export SUDO_EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# Firefox plz
export BROWSER=/usr/bin/firefox

# ZSH Theme
ZSH_THEME=""

# Colorls
source $(dirname $(gem which colorls))/tab_complete.sh
path+=(
    $(ruby -e 'puts File.join(Gem.user_dir, "bin")')
)

# Starship export
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Plugin
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
autoload -U compinit && compinit

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# fzf source
source /usr/share/fzf/key-bindings.zsh

###############################
# ****** ALIAS SECTION ****** #
###############################

# Update thingy
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
# Archives
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias z='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>
# cd and ls after
cd() {
	builtin cd "$@" && command ls --group-directories-first --color=auto -F
}
#alias for play music
alias music='ncmpcpp-art'
# alias for sourcing the zshrc
alias sr='source ~/.zshrc'
# alias for cd up a directory
alias ..="cd .."
# alias for making a directory and cd to it
mcd () {
    mkdir -p $1
    cd $1
}
# alias for searching through ps
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" 
# alias for mkdir so that it makes required parent directory
alias mkdir="mkdir -p"
# alias for ranger
alias fm='ranger'
# alias for colorls
alias ls='colorls'
# alias for searching and installing packages
alias pacs="pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
# alias for searching and installing packages from AUR
alias yays="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro  yay -S"
# alias for searching and removing packages from system
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
# alias for searching packages from system
alias p="pacman -Q | fzf"
# alias for wifi
alias wifi="nmtui-connect"
# alias for grep
alias grep='grep --color=auto'
# alias for Neovim
alias v='nvim'
# alias for verbose cp, mv, rm
alias mv='mv -v'
alias cp='cp -vr'
alias rm='rm -vr'
# alias for running cpp files
rc(){
  g++ "$1" -o run
  ./run
}
# alias for checking dunst
alias dun='killall dunst && dunst &
notify-send "cool1" "yeah it is working"
notify-send "cool2" "yeah it is working"'

# Prompt: git status, hostname for ssh sessions, vi mode indicator
eval "$(starship init zsh)"