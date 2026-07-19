#!/bin/bash
# -------------------------------
# casts / Alice- profle updater for arch 
# v2.4
# -------------------------------
cd ~/Desktop/
echo "
------------------
# casts / Alice- profle updater for arch 
# v2.6
------------------
"
echo "add the music tools [Y/N]" 
read addfunny 
echo "! hit any key to keep going to install. !"
read moveon
# network stuff
sudo ntpdata 0.pool.ntp.org

# que
echo "#-------------------"
echo "hello NM is setup add wifi now"
echo "did you add wifi? / are you ready to build? [Y/N]"
read yesno
echo "#-------------------"

if [[ $yesno =~ ^(Y|y|yes)$ ]]; then
  echo "starting"
# start install 
  sudo pacman -Syu --noconfirm
  sudo pacman -S reflector --noconfirm
  sudo reflector -c US -l 10 -p https --save /etc/pacman.d/mirrorlist
  
# apps and tools stuff 
  sudo pacman -S plasma-meta
  sudo pacman -S bash-completion nano networkmanager yt-dlp git firewalld btop rocm-smi-lib ffmpegthumbnailer fastfetch openssh xdotool most figlet devtools base-devel pacman-contrib picard --noconfirm
# file sys stuff
  sudo pacman -S btrfs-progs dosfstools exfat-utils ntfs-3g nilfs-utils exfatprogs ntfsprogs --noconfirm
# fonts 
  sudo pacman -S adobe-source-han-sans-jp-fonts --noconfirm; fc-cache
# flatpak
  flatpak install flathub org.gnome.gThumb net.davidotek.pupgui2 com.github.tchx84.Flatseal org.libreoffice.LibreOffice com.github.taiko2k.tauonmb org.videolan.VLC org.kde.krita net.davidotek.pupgui2 net.mkiol.SpeechNote org.musicbrainz.Picard

# start firewall
  sudo systemctl start firewalld; sudo systemctl enable firewalld
# mounts
  sudo mkdir -p /mnt/mount{1,2,3,4,5,6,7}
  sudo chown -vR $USER:$USER /mnt/mount* 
  #echo "$USER"
# yay installl
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si 
  cd ..
  rm -rf yay/ 
  yay -S rar unrar
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
" > ~/.bashrc; source ~/.bashrc
    if [[ $addfunny =~ ^(Y|y|yes)$ ]]; then
      echo "
# funny     --------------------------------------
    alias Bsteal='bandcamp-dl -r -e --base-dir ./'
    alias Ysteal='yt-dlp -x --embed-thumbnail --embed-metadata --cookies-from-browser firefox --audio-format mp3'
# funny end --------------------------------------
" >> ~/.bashrc; source ~/.bashrc
     yay -S bandcamp-dl-git
      
   else
     echo "no music tools"
   fi
 # funny end
 # ====================================    
else
  echo "stoping"
fi
