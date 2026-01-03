##############################################################
#
# LDD
#
##############################################################

# Fetch from assignment-7 repository which contains misc-modules and scull
LDD_VERSION = '46e3528d217169f15a9c0a57f9833ff667109fe7'
# Using HTTPS URL since SSH may not be available in build environments
LDD_SITE = 'https://github.com/cu-ecen-aeld/assignment-7-fhe1101.git'
LDD_SITE_METHOD = git

define LDD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules modules KERNELDIR=$(LINUX_DIR) KERNEL_SRC=$(LINUX_DIR) ARCH=arm64
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull modules KERNELDIR=$(LINUX_DIR) KERNEL_SRC=$(LINUX_DIR) ARCH=arm64
endef

# Install misc-modules and scull kernel modules
define LDD_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D)/misc-modules INSTALL_MOD_PATH=$(TARGET_DIR) KERNELDIR=$(LINUX_DIR) ARCH=arm64 modules_install
	mkdir -p $(TARGET_DIR)/opt/aesd-modules
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/opt/aesd-modules/scull_load
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/opt/aesd-modules/scull_unload
	$(INSTALL) -m 0755 $(@D)/scull/scull.ko $(TARGET_DIR)/opt/aesd-modules/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/opt/aesd-modules/module_load
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/opt/aesd-modules/module_unload
endef

$(eval $(generic-package))
