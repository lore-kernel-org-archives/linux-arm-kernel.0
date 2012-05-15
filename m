From: Barry.Song@csr.com (Barry Song)
Date: Tue, 15 May 2012 11:11:18 +0800
Subject: [PATCH] ARM: PRIMA2: add prima2_defconfig for CSR SiRFprimaII
Message-ID: <1337051478-19943-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/prima2_defconfig |   69 +++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/prima2_defconfig

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
new file mode 100644
index 0000000..c328ac6
--- /dev/null
+++ b/arch/arm/configs/prima2_defconfig
@@ -0,0 +1,69 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BSD_DISKLABEL=y
+CONFIG_SOLARIS_X86_PARTITION=y
+CONFIG_ARCH_PRIMA2=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_KEXEC=y
+CONFIG_BINFMT_MISC=y
+CONFIG_PM_RUNTIME=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_SERIAL_SIRFSOC=y
+CONFIG_SERIAL_SIRFSOC_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_SIRF=y
+CONFIG_SPI=y
+CONFIG_SPI_SIRF=y
+CONFIG_SPI_SPIDEV=y
+# CONFIG_HWMON is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_FILE_STORAGE=m
+CONFIG_USB_MASS_STORAGE=m
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_DMADEVICES=y
+CONFIG_DMADEVICES_DEBUG=y
+CONFIG_DMADEVICES_VDEBUG=y
+CONFIG_SIRF_DMA=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_INFO=y
+CONFIG_CRC_CCITT=y
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
