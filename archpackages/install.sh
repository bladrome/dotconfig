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

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
ln -sf /usr/share/zoneinfo/Asia/Shanghai /mnt/etc/localtime
arch-chroot /mnt /bin/bash -c "hwclock --systohc"

arch-chroot /mnt /bin/bash -c locale-gen

echo "LANG=en_US.UTF-8
LC_CTYPE=zh_CN.UTF-8" > /mnt/etc/locale.conf

echo "Thindrome" > /mnt/etc/hostname

echo "127.0.0.1	localhost
::1 		localhost
127.0.0.1	Thindrome" > /mnt/etc/hosts

mkdir /mnt/boot/grub
arch-chroot /mnt /bin/bash -c "pacman -S grub efibootmgr inter-ucode os-prober --noconfirm"
arch-chroot /mnt /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"
arch-chroot /mnt /bin/bash -c "grub-install --target=x86_64-efi --efi-directory=/boot"

arch-chroot /mnt
useradd -m -U bladrome
passwd bladrome
exit

pacman -S yay
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
yay -P -g

yay -S zsh 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zinit/main/doc/install.sh)"

yay -S rofi unclutter slock mousepad firefox maim gpicview feh firefox mpc mpd unclutter xsel slock ttf-droid picom-git
yay -S xorg-xinit xorg-server xf86-viedo-intel xf86-viedo-nouveau  pulseaudio
yay -S lightdm xorg-server-xephyr lightdm-gtk-greeter
yay -S awesome
yay -S termite kitty
yay -S alsa-utils playerctl

git clone https://github.com/bladrome/dotconfig.git
cd dotconfig
cp -a termite ~/.config/
cp -a awesome ~/.config/

chmod u+s /usr/bin/xinit

xrandr --output eDP1 --off
xrandr --output HDMI1 --auto

yay -S noto-fonts
yay -S nerd-fonts-noto
yay -S ttf-hack
yay -S nerd-fonts-source-code-pro


cp Fonts /usr/share/fonts/
fc-cache

yay -S wpa_supplicant dhcpcd
yay -S v2raya

yay -S emacs
git clone --depth 1 https://github.com/seagle0128/.emacs.d.git ~/.emacs.d

yay -S fcitx-rime fcitx-configtools

wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/texlive2019-20190410.iso
mount texlive2019-20190410.iso mountpoint
cd moutpoint
sudo ./install-tl

yay -S polkit udisks2 ntfs-3g gvfs udevil
yay -S glances tree

yay -S python-pip
yay -S zathura zathura-djvu zathura-pdf-poppler zathura-ps poppler poppler-data
yay -S mpv


yay -S mplayer
yay -S xine-lib
yay -S wget neovim unzip  pcmanfm baobab ack curl
yay -S atool bsdtar djvutxt medianinfo odt2txt jq openscad highlight

yay -S firefox
yay -S firefox-i8n-zh-cn

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
