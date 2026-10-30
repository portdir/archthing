#!/bin/bash
setups(){
  cd ~
  mkdir -p ~/setup/
  cd ~/setup/
  allinstalls
};
allinstalls(){
  pacmaninlist="
    plasma-meta
    gparted
    tar
    btrfs-assistant
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
    btrfs-progs
    kdegraphics-thumbnailers
    dosfstools
    exfat-utils
    ntfs-3g
    nilfs-utils
    exfatprogs
    ntfsprogs
    krita
    vlc
    libreoffice-fresh
    gthumb
    adobe-source-han-sans-jp-fonts
    adobe-source-han-sans-kr-fonts
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
  systemctl start firewalld
  systemctl enable firewalld
};
sudostuff(){
  network
  pacman -S --needed base-devel linux-headers --noconfirm
  pacman -S reflector --noconfirm
  reflector -c US -l 10 -p https --save /etc/pacman.d/mirrorlist
  pacman -S --needed  $pacmaninlist --noconfirm
  mkdir -p /mnt/mount{1,2,3,4,5,6,7}
  chown -vR $USER:$USER /mnt/mount* 
  chmod +x /etc/grub.d/10_linux
  grub-mkconfig -o /boot/grub/grub.cfg
};
makeyay(){
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si 
  cd ..
  rm -rf yay/ 
};
runing(){
  echo "
    ------------------
    # casts / Alice- profile updater for arch 
    # v2.9
    ------------------
  "
  echo "add the music tools [Y/N]" 
  read addfunny 
  echo -e "
    #-------------------
    hello setup NM and add wifi now
    did you add wifi? / are you ready to build? [Y/N]
    #-------------------
  "
  read yesno
  if [[ $yesno =~ ^(Y|y|yes)$ ]]; then
    setups
    makeyay
    sudo sudostuff
    flatpak --user install flathub $flathubinlist
    yay -S unrar
    echo -e "
      # things     --------------------------------------
        alias hello='figlet UWU HELLOWO'
        alias grep='grep --color=auto'
        alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
        alias lsa='ls -lsAF'
        alias aliasup='source ~/.bashrc'
        alias pacman='sudo pacman'
        alias fuckgit='thedate=\$(date) && git commit -am \"\$thedate\" && git push'
      # olther end --------------------------------------
        export EDITOR=nano
        export VISUAL=nano
    " > ~/.bashrc; source ~/.bashrc
  fi
  if [[ $addfunny =~ ^(Y|y|yes)$ ]]; then
    yay -S bandcamp-dl-git
    echo "
      # funny     --------------------------------------
          alias Bsteal='bandcamp-dl -r -e --base-dir ./'
          alias Ysteal='yt-dlp -x --embed-thumbnail --embed-metadata --cookies-from-browser firefox --audio-format mp3'
      # funny end --------------------------------------
    " >> ~/.bashrc; source ~/.bashrc
    else
      echo 
    fi
  fc-cache
  mkdir -p ~/.local/share/plasma/look-and-feel/xenia/ 
  wget -qO- https://github.com/astro-cyberpaws/xenia-kde6/releases/latest/download/xenia.tar.gz | gunzip | tar xf - -C ~/.local/share/plasma/look-and-feel/xenia/
};
runing
echo "stoping"
exit 1