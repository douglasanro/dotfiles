set fish_greeting ""

set -gx TERM xterm-256color

# THEME
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
starship init fish | source

# NVM
function __check_rvm --on-variable PWD --description 'Checking nvm...'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end