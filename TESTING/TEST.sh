cat << EOF > out.test
# things --------------------------------------
  alias hello='figlet UWU HELLOWO'
  alias grep='grep --color=auto'
  alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
  alias lsa='ls -lsAF'
  alias aliasup='source ~/.bashrc'
  alias pacman='sudo pacman'
  alias fuckgit='thedate=\$(date) && git commit -am "\$thedate" && git push'
# olther end --------------------------------------
  export EDITOR=nano
  export VISUAL=nano
EOF
cat out.test
