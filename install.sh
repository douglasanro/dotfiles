#!/bin/sh

DOTFILES="$HOME/development/dotfiles"

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
  yes | cp -rf $DOTFILES/.zshrc $(pwd)/.zshrc
  cp $DOTFILES/itermProfile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles

  if ! [ -x "$(command -v brew)" ]; then
    msg_running "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    msg_running "Updating Homebrew"
    brew update
  fi

  msg_running "Silencing Login Message"
  touch ~/.hushlogin

  msg_running "Installing Nerd Fonts"
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  msg_running "Installing Iterm2"
  brew install --cask iterm2

  msg_running "Installing Chrome"
  brew install --cask google-chrome

  msg_running "Installing Firefox"
  brew install --cask firefox

  msg_running "Installing Brave"
  brew install --cask brave-browser

  msg_running "Installing VS Code"
  brew install --cask visual-studio-code

  msg_running "Installing Docker"
  brew install --cask docker

  msg_running "Installing Tiles"
  brew install --cask tiles

  msg_running "Installing Numi"
  brew install --cask numi

  msg_running "Installing NVM"
  brew install nvm

  msg_running "Installing AWS CLI"
  brew install awscli

  msg_running "Installing Exa"
  brew install exa

  msg_running "Installing neofetch"
  brew install neofetch

msg_running "Making Zsh the default shell"
chsh -s $(which zsh)

msg_running "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended

msg_running "Installing SpaceShip ZSH"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"

msg_running "Installing zsh-autosuggestions"
brew install zsh-autosuggestions

msg_running "Installing zsh-syntax-highlighting"
brew install zsh-syntax-highlighting

msg_running "Installing fzf"
brew install fzf
$(brew --prefix)/opt/fzf/install --all

  neofetch
  msg_done "Done!"
}

main "$@"; exit