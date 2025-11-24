
# casts profle updater for arch
cd ~/Desktop/

sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
sudo pacman -Syu

#mounts
sudo mkdir /dev/mounts
sudo mkdir /dev/mounts/mount1
sudo mkdir /dev/mounts/mount2
sudo mkdir /dev/mounts/mount3
sudo mkdir /dev/mounts/mount4

#yay
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay
cd ..
rm -rf yay/

sudo pacman -S flatpak

flatpak install flathub com.github.tchx84.Flatseal

flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub com.github.taiko2k.tauonmb
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.videolan.VLC
flatpak install flathub org.kde.krita
# ====================================
# update bashrc file 
echo "
    # --------------------------------------
    # the things
    # -------------------------------------
    # man colored
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
    export PAGER='most'
    # --------------------------------------
    # olther
    alias hello='figlet UWU HELLOWO'
    alias grep='grep --color=auto'
    alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
    alias lsa='ls -lAsF'
    alias aliasup='source ~/.bashrc'
    alias pacman='sudo pacman'

    alias Ssteal='scdl --original-art --yt-dlp-args '--embed-thumbnail' -l'
    alias Bsteal='bandcamp-dl -r -e --base-dir ./'
    # --------------------------------------
" >> ~/.bashrc

# build 
source ~/.bashrc

# ====================================
# installs

# tools
sudo pacman -S btop rocm-smi-lib fastfetch openssh 
sudo pacman -S yt-dlp
yay -S bandcamp-dl-git # bandcamp-dl
yay -S soundcloud-dl-git # scdl
#olther
sudo pacman -S firefox
# outputs
sudo pacman -S most figlet


