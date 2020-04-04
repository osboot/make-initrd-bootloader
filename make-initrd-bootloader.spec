Name: make-initrd-bootloader
Version: 0.2
Release: alt1

Summary: Bootloader feature for make-initrd
License: GPL-2
Group: System/Base

Source0: %name-%version.tar

BuildRequires: make sed bc flex
BuildRequires: libnewt-devel
BuildRequires: libslang2-devel
BuildRequires: libiniparser-devel
BuildRequires: libssl-devel
BuildRequires: libelf-devel
BuildRequires: kmod

Requires: make-initrd
Requires: kexec-tools

%description
Make-initrd bootloader feature.

%prep
%setup
%make_build

%install
%makeinstall_std

kver="`cat "%buildroot/lib/miboot/boot/version"`"
mv -f -- "%buildroot/lib/miboot/boot/System.map" "%buildroot/lib/miboot/boot/System.map-$kver"
mv -f -- "%buildroot/lib/miboot/boot/config"     "%buildroot/lib/miboot/boot/config-$kver"

mkdir -p %buildroot/%_datadir/make-initrd/features
cp -a feature %buildroot/%_datadir/make-initrd/features/bootloader

modules_dir="$(ls -1d %buildroot/lib/modules/*)"

# No external modules outside of this package.
rm -f -- "$modules_dir"/build
rm -f -- "$modules_dir"/source

rm -f -- "$modules_dir"/modules.{alias,dep,symbols,builtin}.bin
touch -- "$modules_dir"/modules.{alias,dep,symbols,builtin}.bin
touch %buildroot/lib/miboot/boot/miboot.img

%add_findreq_skiplist /usr/share/make-initrd/features/*
%add_verify_elf_skiplist /lib/miboot/boot/vmlinuz-*
%brp_strip_none /lib/miboot/boot/*

%files
/sbin/miboot
/lib/miboot
%ghost /lib/miboot/boot/miboot.img
/lib/modules/*
%ghost /lib/modules/*/modules.alias.bin
%ghost /lib/modules/*/modules.dep.bin
%ghost /lib/modules/*/modules.symbols.bin
%ghost /lib/modules/*/modules.builtin.bin
%config(noreplace) %_sysconfdir/miboot.mk
%_datadir/make-initrd/features/bootloader

%changelog
* Sat Apr 04 2020 Alexey Gladkov <legion@altlinux.ru> 0.2-alt1
- Update files.

* Wed Apr 01 2020 Alexey Gladkov <legion@altlinux.ru> 0.1-alt1
- First build.

