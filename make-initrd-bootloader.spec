%add_findreq_skiplist /usr/share/make-initrd/features/*

Name: make-initrd-bootloader
Version: 0.1
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

rm -f -- %buildroot/lib/modules/*/build
rm -f -- %buildroot/lib/modules/*/source

%files
/sbin/miboot
/lib/miboot
/lib/modules/*
%_sysconfdir/miboot.mk
%_datadir/make-initrd/features/bootloader

%changelog
* Wed Apr 01 2020 Alexey Gladkov <legion@altlinux.ru> 0.1-alt1
- First build.

