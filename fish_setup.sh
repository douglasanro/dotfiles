function msg_running { echo "==> \033[1m🐟 $1 \033[0m"; }
function msg_done { echo "==> \033[1m🌊 $1 \033[0m"; }

function fish_setup {
  msg_running "Installing Starship Theme"
  brew install starship
  starship init fish | source

  msg_running "Installing Fisher"
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

  msg_running "Installing Z"
  fisher install jethrokuan/z

  msg_running "Installing Bass"
  fisher install edc/bass

  msg_running "Installing Plugin Git"
  fisher install jhillyerd/plugin-git
  

  msg_done "Fish Setup Done!"
}

fish_setup "$@"; exit