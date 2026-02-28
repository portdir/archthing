#!/bin/bash
# -------------------------------
# casts profle updater for arch 
# v2.6
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
---- installs ----
# yay
# git 
# firewalld
# btop + rocm-smi-lib <-[this is for gpu]
# fastfetch
# openssh
# xdotool
# firefox
# most
# figlet
# yt-dlp
# bandcamp-dl-git soundcloud-dl-git - funny
------------------
"
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
  sudo pacman -S git firewalld btop rocm-smi-lib fastfetch openssh xdotool firefox most figlet --noconfirm
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
        # --------------------------------------
        # the things
        # --------------------------------------
        # olther
          alias hello='figlet UWU HELLOWO'
          alias grep='grep --color=auto'
          alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
          alias lsa='ls -lsAF'
          alias aliasup='source ~/.bashrc'
          alias pacman='sudo pacman'
          alias yak='xdotool sleep 2 type --delay 10'
        # olther end
        # funny steal
          alias Ssteal='scdl --original-art --yt-dlp-args '--embed-thumbnail' -l'
          alias Bsteal='bandcamp-dl -r -e --base-dir ./'
          alias Ysteal='yt-dlp -x --embed-thumbnail --embed-metadata --cookies-from-browser firefox --audio-format mp3'
        # funny steal end
        # --------------------------------------
   " >> ~/.bashrc
 # build 
   source ~/.bashrc
   
 # ====================================
 # funny
   sudo pacman -S yt-dlp
   yay -S bandcamp-dl-git soundcloud-dl-git
 # funny end
 # ====================================    
else
  echo "stoping"
fi
