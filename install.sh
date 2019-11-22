#!/bin/sh

function msg_running { echo -e "\033[1m🔥 $1 \033[0m"; }
function msg_done { echo -e "\033[1m🚀 $1 \033[0m"; }

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

if test ! $(which brew); then
  msg "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  msg_running "Updating Homebrew"
  brew update
fi

msg_running "Installing Chrome"
brew cask install google-chrome

msg_running "Installing Firefox"
brew cask install firefox

msg_running "Installing VS Code"
brew cask install visual-studio-code

msg_running "Installing VLC"
brew cask install vlc

msg_running "Installing Docker"
brew cask install docker

msg_running "Installing NVM"
brew install nvm

msg_running "Installing Yarn"
brew install yarn

msg_running "Installing Go"
brew install go

msg_running "Installing AWS CLI"
brew install awscli

msg_running "Making Zsh the default shell"
chsh -s $(which zsh)

msg_running "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended

msg_running "Installing SpaceShip ZSH"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"

msg_running "Creating git aliases"
git config --global alias.psh "push origin HEAD"
git config --global alias.up "!git pull --rebase --prune $@ && git submodule update --init --recursive"
git config --global alias.co "checkout"
git config --global alias.cm "checkout master"
git config --global alias.st "status"
git config --global alias.save "!git add -A && git commit -m 'SAVEPOINT'"
git config --global alias.wip "commit -am 'WIP'"
git config --global alias.undo "reset HEAD~1 --mixed"
git config --global alias.amend "commit -a --amend"

msg_done "Done!"