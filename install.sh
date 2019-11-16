#!/bin/bash

function msg_install { echo -e "\033[1m🔥 $1 \033[0m"; }
function msg_done { echo -e "\033[1m🚀 $1 \033[0m"; }

DOTFILES="$HOME/Development/dotfiles"

if [[ -d $DOTFILES ]]; then
  print 'Checking dotfiles directory'
else
  print 'Cloning dotfiles'
  git clone https://github.com/douglasanro/dotfiles.git $DOTFILES
fi

cd $DOTFILES

msg_install "Symlinking Zsh"
ln -s $(pwd)/.zshrc ~/.zshrc

msg_install "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

msg_install "Installing Chrome"
brew cask install google-chrome

msg_install "Installing Firefox"
brew cask install firefox

msg_install "Installing VS Code"
brew cask install visual-studio-code

msg_install "Installing VLC"
brew cask install vlc

msg_install "Installing Docker"
brew cask install docker

msg_install "Installing NVM"
brew install nvm

msg_install "Installing Yarn"
brew install yarn

msg_install "Installing Go"
brew install go

msg_install "Installing AWS CLI"
brew install awscli

msg_install "Making Zsh the default shell"
chsh -s $(which zsh)

msg_install "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

msg_install "Installing SpaceShip ZSH"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

msg_install "Creating git aliases"
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