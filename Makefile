PROJECT = bootloader
VERSION = 1.0.0

BACKEND = ncurses

CFLAGS    = -Os -Wall -Wextra

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
MV       = $(Q)mv
RM       = $(Q)rm -f
CHMOD    = $(Q)chmod
INSTALL  = $(Q)install
MKDIR_P  = $(Q)mkdir -p
TOUCH_R  = $(Q)touch -r
STRIP    = $(Q)strip -s
MAKE     = $(Q)make
SED      = $(call quiet_cmd,SED,$@,sed)
HELP2MAN = $(call quiet_cmd,MAN,$@,env -i help2man -N)
COMPILE  = $(call quiet_cmd,CC,$<,$(COMPILE.c))
LINK     = $(call quiet_cmd,CCLD,$@,$(LINK.o))

all: make-bootloader build-kernel

INSTALL_TARGETS = \
	install-bin \
	install-kernel \
	install-config

install: $(INSTALL_TARGETS)

install-bin: make-bootloader-image make-bootloader-config
	$(MKDIR_P) -- $(DESTDIR)/$(sbindir)
	$(INSTALL) -m755 make-bootloader-image $(DESTDIR)/$(sbindir)/make-bootloader-image
	$(INSTALL) -m755 make-bootloader-config $(DESTDIR)/$(sbindir)/make-bootloader-config

install-config: initrd-bootloader.mk
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
	$(eval KERNEL_VERSION := $(shell make -C linux -s kernelversion))
	$(MV) -f -- "$(DESTDIR)/$(basedir)/boot/System.map" "$(DESTDIR)/$(basedir)/boot/System.map-$(KERNEL_VERSION)"
	$(MV) -f -- "$(DESTDIR)/$(basedir)/boot/config" "$(DESTDIR)/$(basedir)/boot/config-$(KERNEL_VERSION)"

clean:
	$(RM) -- $(PROJECT) $(MENU_PROG)

build-kernel: linux
	$(CP) -f -- kernel.config linux/.config
	$(MAKE) -C linux

$(MENU_PROG): $($(BACKEND)_OBJS)
	$(LINK) $^ $($(BACKEND)_LIBS) -o $@

%: %.in
	$(SED) \
		-e 's,@PROJECT@,$(PROJECT),g' \
		-e 's,@VERSION@,$(VERSION),g' \
		<$< >$@
	$(TOUCH_R) $< $@
	$(CHMOD) --reference=$< $@

%.o: %.c
	$(COMPILE) $(OUTPUT_OPTION) $<

