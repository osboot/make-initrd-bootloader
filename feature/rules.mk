bootloader: create
	@$(MSG) "Building bootloader ..."
	@put-tree "$(ROOTDIR)" $(BOOTLOADER_DATADIR)
	@put-file "$(ROOTDIR)" $(BOOTLOADER_FILES)
	@put-file -r "/lib/bootloader" "$(ROOTDIR)" /lib/bootloader/bin/bootmenu
	@echo "bootloader" > "$(ROOTDIR)/etc/initrd/method"

pack: bootloader

