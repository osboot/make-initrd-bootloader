PROJECT = bootloader
VERSION = 1.0.0

basedir     = /lib/$(PROJECT)
sbindir    ?= /sbin
sysconfdir ?= /etc

Q = @
VERBOSE ?= $(V)
ifeq ($(VERBOSE),1)
    Q =
else
    MAKEFLAGS += --no-print-directory
endif

quiet_cmd = \
	$(if $(VERBOSE),$(3),$(Q)printf "  %-08s%s\n" "$(1)" $(2); $(3))

CP       = $(Q)cp -a
RM       = $(Q)rm -f
CHMOD    = $(Q)chmod
INSTALL  = $(Q)install
MKDIR_P  = $(Q)mkdir -p
TOUCH_R  = $(Q)touch -r
STRIP    = $(Q)strip -s
MAKE     = $(Q)make
SED      = $(call quiet_cmd,SED,$@,sed)

all: make-bootloader build-kernel

INSTALL_TARGETS = \
	install-bin \
	install-kernel \
	install-config

install: $(INSTALL_TARGETS)

install-bin: make-bootloader
	$(MKDIR_P) -- $(DESTDIR)/$(sbindir)
	$(INSTALL) -m755 make-bootloader $(DESTDIR)/$(sbindir)/make-bootloader

install-config:
	$(MKDIR_P) -- $(DESTDIR)/$(sysconfdir)
	$(CP) -f -- initrd-bootloader.mk $(DESTDIR)/$(sysconfdir)/$(PROJECT).mk

install-kernel: linux build-kernel
	$(MKDIR_P) -- $(DESTDIR)/$(basedir)/boot
	$(MKDIR_P) -- $(DESTDIR)/$(basedir)/lib/modules
	$(MAKE) -C linux \
		INSTALLKERNEL=true \
		INSTALL_PATH="$(DESTDIR)/$(basedir)/boot" \
		INSTALL_MOD_PATH="$(DESTDIR)"  \
		install modules_install
	$(MAKE) -C linux -s kernelversion > "$(DESTDIR)/$(basedir)/boot/version"
	$(CP) -f -- linux/.config "$(DESTDIR)/$(basedir)/boot/config"

clean:
	$(RM) -- $(PROJECT) $(MENU_PROG)

build-kernel: linux
	$(CP) -f -- kernel.config linux/.config
	$(MAKE) -C linux

%: %.in
	$(SED) \
		-e 's,@PROJECT@,$(PROJECT),g' \
		-e 's,@VERSION@,$(VERSION),g' \
		<$< >$@
	$(TOUCH_R) $< $@
	$(CHMOD) --reference=$< $@
