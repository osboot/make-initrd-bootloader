bootloader: create
	@$(MSG) "Building bootloader ..."
	@put-tree "$(ROOTDIR)" $(BOOTLOADER_DATADIR)
	@put-file "$(ROOTDIR)" $(BOOTLOADER_FILES)
	@put-file -r "/lib/miboot" "$(ROOTDIR)" /lib/miboot/bin/bootmenu
	@echo "bootloader" > "$(ROOTDIR)/etc/initrd/method"

pack: bootloader

