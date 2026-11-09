# things --------------------------------------
  alias hello='figlet UWU HELLOWO'
  alias grep='grep --color=auto'
  alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
  alias lsa='ls -lsAF'
  alias aliasup='source ~/.bashrc'
  alias pacman='sudo pacman'
  alias installed='pacman -Qqent'
  alias fuckgit='git commit -am \$(date)'
# other end --------------------------------------
  export EDITOR=nano
  export VISUAL=nano
  # https://robotmoon.com/bash-prompt-generator/
  export PS1="\[$(tput setaf 34)\]\u\[$(tput setaf 37)\]@\[$(tput setaf 15)\]\h \[$(tput setaf 149)\]\w \[$(tput sgr0)\]$ "
