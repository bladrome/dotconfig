disco=/dev/sda
wifi=0
set -x

chrootrun () {
    arch-chroot /mnt /bin/bash -c "$@"
}

mkdir -p /usr/local/share/kbd/keymaps
echo 'include "linux-with-two-alt-keys"
     keycode 29 = Caps_Lock
     keycode 58 = Control' > /usr/local/share/kbd/keymaps/personal.map
echo 'KEYMAP=/usr/local/share/kbd/keymaps/personal.map' > /etc/vconsole.conf
loadkeys /etc/vconsole.conf
clear

if [ $wifi -ne 0 ]
then
    ip link set wlan0 up
    wpa_passphrase "BSSID" "PASSWORD" > wifi.conf
    wpa_supplicant -B -i wlan0 -c wifi.conf
    dhcpcd dhclient &
fi
clear

timedatectl set-ntp true
clear

sgdisk --zap-all ${disco}
sgdisk ${disco} -n=1:0:+1M -t=1:ef02
sgdisk ${disco} -n=2:0:+1024M -t=2:8300
sgdisk ${disco} -n=3:0:0 -t=3:8300
mkfs.fat -F32 ${disco}2
mkfs.btrfs -f -L "root"  ${disco}3
clear

echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman -Syy
clear

mount ${disco}3 /mnt
mkdir -p /mnt/boot
mount ${disco}2 /mnt/boot
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
clear

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
mkdir /mnt/boot/grub
chrootrun "pacman -S grub efibootmgr os-prober --noconfirm"
chrootrun "grub-install --target=i386-pc ${disco}"
chrootrun "grub-mkconfig -o /boot/grub/grub.cfg"
clear

ln -sf /usr/share/zoneinfo/Asia/Shanghai /mnt/etc/localtime
chrootrun "hwclock --systohc"
clear

echo 'en_US.UTF-8 UTF-8
zh_CN.GB18030 GB18030
zh_CN.GBK GBK
zh_CN.UTF-8 UTF-8
zh_CN GB2312' >> /mnt/etc/locale.gen
chrootrun locale-gen
clear

echo "LANG=en_US.UTF-8
LC_CTYPE=zh_CN.UTF-8" > /mnt/etc/locale.conf
clear

echo "Thindrome" > /mnt/etc/hostname
clear

echo "127.0.0.1	localhost
::1 		localhost
127.0.0.1	Thindrome" > /mnt/etc/hosts
clear

echo '[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch' >> /mnt/etc/pacman.conf
chrootrun "pacman -Syy --noconfirm"
chrootrun "pacman -S archlinuxcn-keyring --noconfirm"
clear

chrootrun "pacman -S --noconfirm yay doas"
chrootrun "yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save"
chrootrun "yay -P -g"
clear

chrootrun "yay -S --noconfirm zsh"
clear

chrootrun "yay -S --noconfirm xorg-xinit xorg-server xf86-viedo-intel xf86-viedo-nouveau pulseaudio"
chrootrun "yay -S --noconfirm xorg-server-xephyr sddm"
chrootrun "yay -S --noconfirm awesome-git"
chrootrun "yay -S --noconfirm rofi unclutter slock mousepad maim gpicview feh mpc mpd unclutter xsel slock ttf-droid picom-git"
chrootrun "yay -S --noconfirm termite kitty"
chrootrun "yay -S --noconfirm alsa-utils playerctl"
clear

chrootrun "yay -S --noconfirm noto-fonts nerd-fonts-noto ttf-hack nerd-fonts-source-code-pro"
clear

chrootrun "yay -S --noconfirm wpa_supplicant dhcpcd"
chrootrun "yay -S --noconfirm v2raya"
clear

chrootrun "yay -S --noconfirm fcitx-rime fcitx-configtools"
clear

chrootrun "yay -S --noconfirm polkit udisks2 ntfs-3g gvfs udevil stow"
chrootrun "yay -S --noconfirm glances tree"
chrootrun "yay -S --noconfirm python-pip"
chrootrun "yay -S --noconfirm zathura zathura-djvu zathura-pdf-poppler zathura-ps poppler poppler-data"
chrootrun "yay -S --noconfirm mpv mplayer"
chrootrun "yay -S --noconfirm xine-lib"
chrootrun "yay -S --noconfirm wget neovim unzip  pcmanfm baobab ack curl"
chrootrun "yay -S --noconfirm atool bsdtar djvutxt medianinfo odt2txt jq openscad highlight"
chrootrun "yay -S --noconfirm firefox"
chrootrun "systemctl enable sddm"
clear
