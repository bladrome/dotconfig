disco=/dev/sda
wifi=0

echo 'include "linux-with-two-alt-keys"
     keycode 29 = Caps_Lock
     keycode 58 = Control' > /usr/local/share/kbd/keymaps/personal.map
echo 'KEYMAP=/usr/local/share/kbd/keymaps/personal.map' > /etc/vconsole.conf

if [ $wifi -ne 0 ]
then
ip link set wlan0 up
wpa_passphrase "BSSID" "PASSWORD" > wifi.conf
wpa_supplicant -B -i wlan0 -c wifi.conf
dhcpcd dhclient
fi

timedatectl set-ntp true

sgdisk --zap-all ${disco}
sgdisk ${disco} -n=1:0:+100M -t=1:ef00
sgdisk ${disco} -n=2:0:0 -t=2:8300

mkfs.fat -F32 ${disco}1
mkfs.btrfs -f -L "root"  ${disco}2

echo 'Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
pacman -Syy

mount ${disco}2 /mnt
mkdir -p /mnt/boot
mount ${disco}1 /mnt/boot
pacstrap /mnt base linux linux-firmware
genfstrab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash -c locale-gen

echo "LANG=en_US.UTF-8
LC_CTYPE=zh_CN.UTF-8" > /mnt/etc/locale.conf

echo "Thindrome" > /mnt/etc/hostname

echo "127.0.0.1	localhost
::1 		localhost
127.0.0.1	Thindrome" > /mnt/etc/hosts

yay -S tmux
git clone https://github.com/gpakosz/.tmux.git
ln -sf .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

yay -S ranger
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> ~/.config/ranger/rc.conf

sudo pacman -S atool
git clone https://github.com/maximtrp/ranger-archives.git ~/.config/ranger/plugins/ranger-archives
cd ~/.config/ranger/plugins/ranger-archives
make install

gpg --keyserver pool.sks-keyservers.net --recv-keys # for linux-xanmod
yay
yay -Syyu
yay -Sc
yay -Rc
yay -Rs
yay -Q
yay -Qe
yay -Qdt
