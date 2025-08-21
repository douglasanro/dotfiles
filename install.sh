#!/bin/sh

DOTFILES="$HOME/Development/dotfiles"

function msg_running { echo "==> \033[1m🔥 $1 \033[0m"; }
function msg_done { echo "==> \033[1m🚀 $1 \033[0m"; }

function main {
  if [[ -d $DOTFILES ]]; then
    msg_running 'Checking dotfiles directory'
  else
    msg_running 'Cloning dotfiles'
    git clone https://github.com/douglasanro/dotfiles.git $DOTFILES
  fi

  cd $DOTFILES


  if ! [ -x "$(command -v xcode-select)" ]; then
    echo "Installing Developer Tools"
    xcode-select --install
  else
    echo "Checking Developer Tools"
  fi

  msg_running "Copying configs"
  yes | cp -rf $DOTFILES/.zshrc $HOME/.zshrc
  yes | cp -rf $DOTFILES/.p10k.zsh $HOME/.p10k.zsh

  if ! [ -x "$(command -v brew)" ]; then
    msg_running "Installing Homebrew"
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo >> /Users/douglas/.zprofile
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/douglas/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    msg_running "Updating Homebrew"
    brew update
  fi

  msg_running "Silencing Login Message"
  touch ~/.hushlogin

  msg_running "Installing Nerd Fonts"
  brew install --cask font-hack
  brew install --cask font-meslo-for-powerlevel10k
  brew install --cask font-meslo-lg

  msg_running "Installing Ghostty"
  brew install --cask ghostty

  msg_running "Installing Chrome"
  brew install --cask google-chrome

  msg_running "Installing Firefox"
  brew install --cask firefox

  msg_running "Installing Arc"
  brew install --cask arc

  msg_running "Installing VS Code"
  brew install --cask visual-studio-code

  msg_running "Installing Docker"
  brew install --cask docker

  msg_running "Installing Raycast"
  brew install --cask raycast

  msg_running "Installing NVM"
  brew install nvm

  msg_running "Installing Neovim"
  brew install neovim

  msg_running "Installing Tmux"
  brew install tmux

  msg_running "Installing fastfetch"
  brew install fastfetch

  msg_running "Making Zsh the default shell"
  chsh -s $(which zsh)

  msg_running "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  msg_running "Installing powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  msg_running "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  msg_running "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  if ! command -v lvim >/dev/null; then
    msg_running "Installing LunarVim"
    INTERACTIVE_MODE=0 LV_BRANCH='release-1.3/neovim-0.9' sh -c "$(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)"
  fi

  fastfetch
  msg_done "Done!"
}

main "$@"; exit
