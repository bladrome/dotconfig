set -x
DISCO=/dev/vda
WIFI=0
if [ -d /sys/firmware/efi/efivars ]; then EFI=1 else EFI=0; fi

chrootrun () {
    clear
    arch-chroot /mnt /bin/bash -c "$@"
}

mkdir -p /usr/local/share/kbd/keymaps
echo '
include "linux-with-two-alt-keys"
keycode 29 = Caps_Lock
keycode 58 = Control' > /usr/local/share/kbd/keymaps/personal.map
echo 'KEYMAP=/usr/local/share/kbd:/keymaps/personal.map' > /etc/vconsole.conf
loadkeys /etc/vconsole.conf

if [ $WIFI -ne 0 ]
then
    ip link set wlan0 up
    wpa_passphrase "BSSID" "PASSWORD" > wifi.conf
    wpa_supplicant -B -i wlan0 -c wifi.conf
    dhcpcd dhclient &
fi

timedatectl set-ntp true

sgdisk --zap-all ${DISCO}
if [ $EFI -eq 0 ]
then
    sgdisk ${DISCO} -n=1:0:+1M -t=1:ef02
    sgdisk ${DISCO} -n=2:0:+1024M -t=2:8300
    sgdisk ${DISCO} -n=3:0:0 -t=3:8300
    PARTBOOT=${DISCO}2
    PARTROOT=${DISCO}3
else
    sgdisk ${DISCO} -n=1:0:+2048M -t=1:ef00
    sgdisk ${DISCO} -n=2:0:0 -t=2:8300
    PARTBOOT=${DISCO}1
    PARTROOT=${DISCO}2
fi
mkfs.fat -F32 $PARTBOOT
mkfs.btrfs -f -L "root"  $PARTROOT

echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman -Syy

mount $PARTROOT /mnt
mkdir -p /mnt/boot
mount $PARTBOOT /mnt/boot
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
clear

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
mkdir /mnt/boot/grub
chrootrun "pacman -S grub efibootmgr os-prober --noconfirm"
if [ $EFI -eq 0 ]
then
    chrootrun "grub-install --target=i386-pc ${DISCO}"
else
    chrootrun "grub-install --target=x86_64-efi ${DISCO}"
fi
chrootrun "grub-mkconfig -o /boot/grub/grub.cfg"

ln -sf /usr/share/zoneinfo/Asia/Shanghai /mnt/etc/localtime
chrootrun "hwclock --systohc"

echo '
en_US.UTF-8 UTF-8
zh_CN.GB18030 GB18030
zh_CN.GBK GBK
zh_CN.UTF-8 UTF-8
zh_CN GB2312' >> /mnt/etc/locale.gen
chrootrun locale-gen

echo '
LANG=en_US.UTF-8
LC_CTYPE=zh_CN.UTF-8' > /mnt/etc/locale.conf

echo 'Thindrome' > /mnt/etc/hostname

echo '
127.0.0.1	localhost
::1 		localhost
127.0.0.1	Thindrome' > /mnt/etc/hosts

echo '
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch' >> /mnt/etc/pacman.conf
chrootrun "pacman -Syy --noconfirm"
chrootrun "pacman -S archlinuxcn-keyring --noconfirm"

chrootrun "pacman -S --noconfirm paru doas"
chrootrun 'paru --aururl "https://aur.tuna.tsinghua.edu.cn" --save'
chrootrun "paru -P -g"

chrootrun "paru -S --noconfirm zsh"

chrootrun "paru -S --noconfirm xorg-xinit xorg-server xf86-viedo-intel xf86-viedo-nouveau pulseaudio"
chrootrun "paru -S --noconfirm xorg-server-xephyr sddm"
chrootrun "paru -S --noconfirm awesome-git"
chrootrun "paru -S --noconfirm rofi unclutter slock mousepad maim gpicview feh mpc mpd unclutter xsel slock picom-git"
chrootrun "paru -S --noconfirm termite kitty"
chrootrun "paru -S --noconfirm alsa-utils playerctl"

chrootrun "paru -S --noconfirm ttf-dejavu ttf-droid ttf-font-awesome noto-fonts nerd-fonts-noto ttf-hack nerd-fonts-source-code-pro"

chrootrun "paru -S --noconfirm wpa_supplicant dhcpcd"
chrootrun "paru -S --noconfirm v2raya"

chrootrun "paru -S --noconfirm fcitx-rime fcitx-configtools"

chrootrun "paru -S --noconfirm polkit udisks2 ntfs-3g gvfs udevil stow"
chrootrun "paru -S --noconfirm glances tree"
chrootrun "paru -S --noconfirm python-pip"
chrootrun "paru -S --noconfirm zathura zathura-djvu zathura-pdf-poppler zathura-ps poppler poppler-data"
chrootrun "paru -S --noconfirm mpv mplayer"
chrootrun "paru -S --noconfirm xine-lib"
chrootrun "paru -S --noconfirm wget neovim unzip  pcmanfm baobab ack curl"
chrootrun "paru -S --noconfirm atool bsdtar djvutxt medianinfo odt2txt jq openscad highlight"
chrootrun "paru -S --noconfirm firefox"
chrootrun "systemctl enable sddm"
