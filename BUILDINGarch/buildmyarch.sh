#!/bin/bash
setups(){
  cd "$HOME" || return
  mkdir -p ~/setup/
  cd "$HOME"/setup/ || return
};

allinstalls(){
  pacmaninlist="
  rust
  speedtest-cli
  plasma-meta
  kwallet
  gparted
  tar
  kate
  btrfs-assistant
  snapper
  btrfs-progs
  bash-completion
  nano
  networkmanager
  yt-dlp
  git
  github-cli
  firewalld
  btop
  rocm-smi-lib
  ffmpegthumbnailer
  fastfetch
  openssh
  xdotool
  most
  figlet
  devtools
  base-devel
  pacman-contrib
  picard
  kdegraphics-thumbnailers
  dosfstools
  exfat-utils
  ntfs-3g
  nilfs-utils
  exfatprogs
  ntfsprogs
  krita
  blender
  vlc
  vlc-plugins-all
  libreoffice-fresh
  gthumb
  adobe-source-han-sans-jp-fonts
  adobe-source-han-sans-kr-fonts
  languagetool
  hunspell-en_us
  "
  flathubinlist="
  net.davidotek.pupgui2
  com.github.tchx84.Flatseal
  com.github.taiko2k.tauonmb
  net.mkiol.SpeechNote
  net.mkiol.SpeechNote.Addon.amd
  com.discordapp.Discord
  "
};
network(){
  pacman -Syu --noconfirm
  ntpdata 0.pool.ntp.org 
};
sudostuff(){
  network
  pacman -S --needed base-devel linux-headers --noconfirm
  pacman -S reflector --noconfirm
  reflector -c US -l 10 -p https --save /etc/pacman.d/mirrorlist
  pacman -S --needed  "$pacmaninlist" --noconfirm
  systemctl start languagetool.service
  systemctl enable languagetool.service
  systemctl start firewalld
  systemctl enable firewalld
  mkdir -p /mnt/mount{1,2,3,4,5,6,7}
  chown -vR "$USER":"$USER" /mnt/mount*
  chmod +x /etc/grub.d/10_linux
  grub-mkconfig -o /boot/grub/grub.cfg
};
makeyay(){
  git clone https://aur.archlinux.org/yay.git
  cd "$HOME"/setup/yay || return
  makepkg -si
  cd "$HOME"/setup || return
  rm -rf "$HOME"/setup/yay
};
runing(){
  echo "
------------------
# casts / Alice - profile updater for arch
# v2.9
------------------
  "
  echo "add the funny tools [Y/N]" 
  read -r addfunny
  echo -e "
#-------------------
hello setup NM and add wifi now
did you add wifi? / are you ready to build? [Y/N]
#-------------------
"
  read -r yesno
  if [[ $yesno =~ ^(Y|y|yes|)$ ]]; then
    setups
    makeyay
    sudostuff
    flatpak --user install flathub "$flathubinlist"

    touch "$HOME"/.bashrc
    cp -f "$PWD"/.bashrc "$HOME"/.bashrc
    yay -S unrar

  fi
  if [[ $addfunny =~ ^(Y|y|yes|)$ ]]; then
    yay -S bandcamp-dl-git
    pacman -S --noconfirm mixxx
    cat << EOF > "$HOME"/.bashrc
# funny     --------------------------------------
  alias Bsteal='bandcamp-dl -r -e --base-dir ./'
  alias Ysteal='yt-dlp -x --embed-thumbnail --embed-metadata --cookies-from-browser firefox --audio-format mp3'
# funny end --------------------------------------
EOF
    # PINCE
    cd "$HOME"/setup || return
    git clone --recursive https://github.com/korcankaraokcu/PINCE
    sh "$HOME"/setup/PINCE/install.sh
    cd "$HOME"/setup || return
    # silly xenia
    mkdir -p "$HOME"/.local/share/plasma/look-and-feel/xenia/
    wget -qO- https://github.com/astro-cyberpaws/xenia-kde6/releases/latest/download/xenia.tar.gz | gunzip | tar xf - -C "$HOME"/.local/share/plasma/look-and-feel/xenia/
  fi
  fc-cache
  $(dirname "${BASH_SOURCE[0]}") "$HOME"/.bashrc
};

allinstalls
runing

echo "stopping"
exit 1


