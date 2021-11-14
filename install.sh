#!/bin/bash

if [[ $EUID > 0 ]]
then echo "Please run as root (or just use sudo)."
	exit
fi

echo "WARNING: The ONLY way to run this is as root (or sudo).\n"
echo "Make sure you ran it this way."
sleep 3

# User creation ===
printf "Creating new user. Username: "
read USERNAME

USER_HOME=/home/$USERNAME

useradd $USERNAME -m -g wheel --groups lp

passwd $USERNAME
# ===

hostnamectl set-hostname archio

pacman --noconfirm -Syu

# Default on lots of distros
pacman --noconfirm -S sudo man-db parted vi tree zip unzip git python3 rclone
pacman --noconfirm -S alsa pavucontrol pulseaudio

# Command line stuff
pacman --noconfirm -S tldr tokei neofetch ripgrep fzf neovim emacs zsh openssh gcc ntfs-3g htop cronie
pacman --noconfirm -S youtube-dl shellcheck cmatrix playerctl translate-shell qrencode

# Graphics card specific
pacman --noconfirm -S mesa radeontop

# Wayland
pacman --noconfirm -S sway swaylock swaybg waybar
pacman --noconfirm -S wl-clipboard
pacman --noconfirm -S xorg-xwayland xorg-xeyes
pacman --noconfirm -S imv swappy grim slurp

# Gui
pacman --noconfirm -S alacritty
pacman --noconfirm -S firefox
pacman --noconfirm -S vlc qbittorrent

# Bluetooth (mostly left to user to configure)
pacman --noconfirm -S bluez bluez-utils pulseaudio-bluetooth
systemctl enable --now bluetooth.service
pacman --noconfirm -S blueman
rfkill unblock bluetooth

# ============  Maximal install =================
pacman --noconfirm -S --needed base-devel noto-fonts-emoji
pacman --noconfirm -S cmake ninja

# --- Install paru (AUR helper) ----
#cd ~
#git clone https://aur.archlinux.org/paru.git
#makepkg -si --asdeps --noconfirm
#rm -rf ~/paru
#
#paru -S brave-bin otf-san-francisco wlsunset
# ----------------------------------
# -----------Without paru-----------

#cd ~
#mkdir -pv aur
#cd aur
#
#git clone https://aur.archlinux.org/brave-bin.git
#cd brave-bin
#makepkg -si --asdeps --noconfirm
#cd ../
#
#git clone https://aur.archlinux.org/packages/wlsunset/
#cd wlsunset
#makepkg -si --asdeps --noconfirm
#cd ../
#
#git clone https://aur.archlinux.org/packages/otf-san-francisco/
#cd otf-san-francisco
#makepkg -si --asdeps --noconfirm
#cd ../
#
#cd ~
#rm -rfv aur


# ----------------------------------

#pacman --noconfirm -S --needed texlive-most 
#pacman --noconfirm -S --needed libreoffice-still pandoc

# ===============================================


# Neovim plugins
# Set correct permissions
chown -Rv $USERNAME $USER_HOME/*
# Download vim-plug
sudo -u $USERNAME curl -fLo "${XDG_DATA_HOME:-$USER_HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins with vim-plug (:PlugInstall)
sudo -u $USERNAME nvim --headless +PlugInstall +qall

mkdir -pv /usr/share/dict/hunspell-custom
cp -v backup/dictionaries/* /usr/share/dict/hunspell-custom/
#------------------------

mkdir /mnt/sda1 ; mkdir /mnt/sda2 ; mkdir /mnt/sda3 ; mkdir /mnt/sda4
mkdir /mnt/sdb1 ; mkdir /mnt/sdb2 ; mkdir /mnt/sdb3 ; mkdir /mnt/sdb4
mkdir /mnt/sdc1 ; mkdir /mnt/sdc2 ; mkdir /mnt/sdc3 ; mkdir /mnt/sdc4
mkdir /mnt/sdd1 ; mkdir /mnt/sdd2 ; mkdir /mnt/sdd3 ; mkdir /mnt/sdd4


mkdir -v    $USER_HOME/.config
mkdir -v    $USER_HOME/.scripts
mkdir -pv   $USER_HOME/.local/share/fonts

mkdir -pv   $USER_HOME/.cache/temp_my_ms

cp -rv backup/.config/*                 $USER_HOME/.config/
cp -rv backup/.scripts/*                $USER_HOME/.scripts
cp -rv backup/.local/share/fonts/*      $USER_HOME/.local/share/fonts/

cp -v backup/.zshenv                    $USER_HOME/.zshenv
cp -v backup/.profile                   $USER_HOME/.profile
cp -v backup/.inputrc                   $USER_HOME/.inputrc

# Wallpaper
mkdir -pv                               $USER_HOME/Pictures/
cp -r backup/wallpaper/                 $USER_HOME/Pictures/wallpaper/

# Screenshots
mkdir -pv $USER_HOME/Pictures/screenshots

# Install fonts placed in .local
fc-cache -f -v

# ==== Personal ======
# Sets up crontab/cronjob for $USER
crontab -u $USERNAME        backup/crontab

cp -rv backup/.ssh          $USER_HOME/.ssh

# https://github.com/cjnaz/rclonesync-V2
sudo -u $USERNAME mkdir $USER_HOME/sync
sudo -u $USERNAME $USER_HOME/.scripts/rclonesync --first-sync --verbose db:/sync $USER_HOME/sync/
# ====================

# Make sure all the files are owned by the local user and not by the root account
chown -Rv $USERNAME $USER_HOME/

# Changes the default shell from zsh, you must relog for this to take effect
chsh -s /bin/zsh $USERNAME 
