<!-- HEADERS -->
<p align="center">
  <img width="25%" src="https://github.com/rxyhn.png" />
</p>

<p align="center">
  <b> ~ Rxyhn's configuration files ~ </b>
</p>

<!-- BADGES -->
<div align="center">
    <p></p>
    <a href="https://github.com/rxyhn/dotfiles/stargazers">
        <img src="https://img.shields.io/github/stars/rxyhn/dotfiles?color=%23BB9AF7&labelColor=%231A1B26&style=for-the-badge">
    </a>
    <a href="https://github.com/rxyhn/dotfiles/network/members/">
        <img src="https://img.shields.io/github/forks/rxyhn/dotfiles?color=%237AA2F7&labelColor=%231A1B26&style=for-the-badge">
    </a>
   <img src="https://badges.pufler.dev/visits/rxyhn/dotfiles?style=for-the-badge&color=73daca&logoColor=white&labelColor=1A1B26"/>
</div>

<!-- INFORMATION -->
### Thanks for dropping by!

<img src="https://raw.githubusercontent.com/rxyhn/dotfiles/main/TokyoNight.png" alt="img" align="right" width="400px">

This is my personal collection of configuration files.

You are probably here for my **Aesthetic BSPWM** configuration.

The [setup section](#setup) will guide you through the installation process.

Here are some details about my setup:

   - **WM:**                   [bspwm](https://github.com/baskerville/bspwm)
   - **OS:**                   [Arch Linux](https://archlinux.org)
   - **Terminal:**             [kitty](https://github.com/kovidgoyal/kitty)
   - **Shell:**                [zsh](https://wiki.archlinux.org/index.php/Zsh)
   - **Widgets:**              [eww](https://github.com/elkowar/eww)
   - **Compositor:**           [picom](https://github.com/ibhagwan/picom)
   - **Editor:**               [neovim](https://github.com/neovim/neovim)
   - **Browser:**              [firefox](https://www.mozilla.org/en-US/firefox)
   - **File Manager:**         [thunar](https://github.com/xfce-mirror/thunar)
   - **Application Launcher:** [rofi](https://github.com/davatorium/rofi)

---

<!-- SETUP -->
## Setup.

   > This is step-by-step how to install these dotfiles. Just [R.T.F.M](https://en.wikipedia.org/wiki/RTFM).

### Installation (Manual)

   > After cloning the repository, install the necessary dependencies to replicate by setup.

   <details open>
   <summary><strong>Arch Linux (and Arch-based distributions)</strong></summary>

   > Assuming your **AUR Helper** is [yay](https://github.com/Jguer/yay).

   ```sh
    $ yay -S bspwm sxhkd rofi kitty picom-ibhagwan-git calcurse todotxt \
    feh jq dunst betterlockscreen brightnessctl playerctl maim \
    xclip imagemagick
     
   ```

   </details>

   <br>

   > Then after the dependencies are installed, copy the files to it's respective folders.

   <details open>
   <summary><strong>Config and Binaries</strong></summary>

   ```sh
    $ mkdir -p $HOME/.config/ && cp -r ./config/* $HOME/.config/
    $ mkdir -p $HOME/.local/bin/ && cp -r ./bin/* $HOME/.local/bin/
    $ cp -r ./misc/* $HOME/
   ```

   </details>

   <br>

   > You will need to install a few fonts.

   - **Cartograph CF:** [here](https://coding-fonts.css-tricks.com/fonts/cartograph-cf/)
   - **JetBrainsMono NF:** [here](https://github.com/ryanoasis/nerd-fonts)
   - **Font Awesome:** [here](https://fontawesome.com/download)
   - **Comic Mono   :** [here](https://dtinth.github.io/comic-mono-font/)


   <br>

   > Once finished copying the files, you might want to finalize the changes to your system.

   ```sh
    # Rebuilds the font cache
    $ fc-cache -fv
   ```

   <br>

   > Lastly, log out from your current desktop session and log in into bspwm.

   <br>

## Miscellaneous.

   - **Elkowar's Wacky Widgets**   
      > If you're **NOT** using a monitor with a 1366x768 resolution, you might want to change the `x` and `y` values of the widgets on the config.

   - **GTK Theme**
      > You can find TokyoNight GTK theme [here](https://github.com/koiosdev/Tokyo-Night-Linux/tree/master/usr/share/themes/TokyoNight).

   - **Icon Theme <kbd>Suggested</kbd>**
      > You can install [this](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) icon theme that suits the GTK theme.


## Acknowledgements.

   - **Contributors**
      - [niraj](https://github.com/niraj998/) for some widgets.

   <br>

<p align="center"><a href="https://github.com/rxyhn/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat-square&label=License&message=GPL-3.0&logoColor=eceff4&logo=github&colorA=1A1B26&colorB=F7768E"/></a></p>
