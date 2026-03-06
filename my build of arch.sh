#!/bin/bash
# -------------------------------
# casts profle updater for arch 
# v2.0
# -------------------------------
cd ~/Desktop/
echo "
------------------
thing that happen.
---- turns on ----
# NetworkManager
# firewalld
------ edit ------
# ~/.bashrc - thay are CMDs that i use like 'yak' this types out stuff after the cmd like copy and paste
# adds mounts at /mnt/mount{1,2,3,4,5,6,7}
# adds JP fonts
---- installers ----
# flatpack 
# yay
# pacman 
------------------
"
echo "add the !funny!? [Y/N]" 
read addfunny 
echo "! hit any key to keep going to install. !"
read moveon
# network stuff
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
# que
echo "#-------------------"
echo "hello NM is setup add wifi now"
echo "did you add wifi? / are you read to build? [Y/N]"
read yesno
echo "#-------------------"

if [[ $yesno =~ ^(Y|y|yes)$ ]]; then
  echo "starting"
# start install 
  sudo pacman -Syu --noconfirm
# apps and tools stuff 
  sudo pacman -S git firewalld btop rocm-smi-lib ffmpegthumbnailer fastfetch openssh xdotool firefox most figlet devtools base-devel pacman-contrib --noconfirm
  # fonts 
  sudo pacman -S adobe-source-han-sans-jp-fonts --noconfirm
  fc-cache
  # fonts -
  
  flatpak install flathub com.github.tchx84.Flatseal org.libreoffice.LibreOffice com.github.taiko2k.tauonmb org.videolan.VLC org.kde.krita net.davidotek.pupgui2 
# start firewall
  sudo systemctl start firewalld
  sudo systemctl enable firewalld
# mounts
  sudo mkdir -p /mnt/mount{1,2,3,4,5,6,7}
  sudo chown -vR $USER:$USER /mnt/mount* 
  #echo "$USER"
# yay installl
  git clone https://aur.archlinux.org/yay.git
  cd ~/Desktop/yay
  makepkg -si
  cd ..
  rm -rf yay/ 
# ====================================
# update bashrc file 
  echo "
# things     --------------------------------------
    alias hello='figlet UWU HELLOWO'
    alias grep='grep --color=auto'
    alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
    alias lsa='ls -lsAF'
    alias aliasup='source ~/.bashrc'
    alias pacman='sudo pacman'
    alias yak='xdotool sleep 2 type --delay 10'
# olther end --------------------------------------
" > ~/.bashrc
   # build 
   source ~/.bashrc
    # ====================================
    # funny 
    if [[ $addfunny =~ ^(Y|y|yes)$ ]]; then
      echo "
# funny     --------------------------------------
    alias Ssteal='scdl --original-art --yt-dlp-args '--embed-thumbnail' -l'
    alias Bsteal='bandcamp-dl -r -e --base-dir ./'
    alias Ysteal='yt-dlp -x --embed-thumbnail --embed-metadata --cookies-from-browser firefox --audio-format mp3'
# funny end --------------------------------------
" >> ~/.bashrc
      sudo pacman -S yt-dlp
      yay -S bandcamp-dl-git soundcloud-dl-git
   else
     echo "no funny"
   fi
 # funny end
 # ====================================    
else
  echo "stoping"
fi
