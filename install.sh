#!/bin/sh

function msg_running { echo "==> \033[1m🔥 $1 \033[0m"; }
function msg_done { echo "==> \033[1m🚀 $1 \033[0m"; }

DOTFILES="$HOME/Development/dotfiles"

if [[ -d $DOTFILES ]]; then
  msg_running 'Checking dotfiles directory'
else
  msg_running 'Cloning dotfiles'
  git clone https://github.com/douglasanro/dotfiles.git $DOTFILES
fi

cd $DOTFILES

msg_running "Symlinking Zsh"
ln -s $(pwd)/.zshrc ~/.zshrc

if ! [ -x "$(command -v brew)" ]; then
  msg_running "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/main/install.sh)"
else
  msg_running "Updating Homebrew"
  brew update
fi

msg_running "Installing Chrome"
brew cask install google-chrome

msg_running "Installing Firefox"
brew cask install firefox

msg_running "Installing Brave"
brew cask install brave-browser

msg_running "Installing VS Code"
brew cask install visual-studio-code

msg_running "Installing VLC"
brew cask install vlc

msg_running "Installing Docker"
brew cask install docker

msg_running "Installing Tiles"
brew cask install tiles

msg_running "Installing MonitorControl"
brew cask install monitorcontrol

msg_running "Installing NVM"
brew install nvm

msg_running "Installing Yarn"
brew install yarn

msg_running "Installing Go"
brew install go

msg_running "Installing AWS CLI"
brew install awscli

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