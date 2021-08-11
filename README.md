# make-initrd bootloader utils
This repo contains utils for more convinient work with bootloader make-initrd feature.

## Installation
To build utils and linux bootloader kernel you may use Makefile
```bash
make
sudo make install
```

## Usage

### make-initrd-image
To build initrd image for bootloader you may use make-intird-image util. Using _-b_ option you may specify boot directory where you want to install bootloader.
> Notice that current version of bootloader using grub to boot yourself. Therefore inside boot directory you has to have mounted efi partion (inside _efi/_ dir) for grub.

### make-initrd-config
To build bootloader config file (_bootloader.conf_) you may use make-initrd-config util. This config has to be places inside _/boot_ directory of target root.

## Example
For example you want to boot place bootloader at the external drive /dev/sda and has real root at the /dev/sdb1 partiotion.
```bash
# mount partion for bootloader kernel and initrd image
mount /dev/sdb2 /media/boot

# mount partition for bootloader esp
mkdir -p /media/boot/efi
mount /dev/sdb1 /media/boot/efi

# install kernel, initrd and grub 
make-initrd-image -b /media/boot

# create bootloader config at the /boot directory
make-initrd-config
```
