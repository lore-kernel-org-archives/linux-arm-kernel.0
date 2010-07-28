From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 28 Jul 2010 10:01:41 -0700
Subject: [PATCH] ARM: phy3250_defconfig: Default kernel configuration
In-Reply-To: <1280336501-16058-1-git-send-email-wellsk40@gmail.com>
References: <1280336501-16058-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280336501-16058-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

This kernel config file has been posted as a seperate patch from
the main lpc32xx arch files. You'll probably need it to build a
Phytec 3250 board kernel.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/configs/phy3250_defconfig |   89 ++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/phy3250_defconfig

diff --git a/arch/arm/configs/phy3250_defconfig b/arch/arm/configs/phy3250_defconfig
new file mode 100644
index 0000000..415b49f
--- /dev/null
+++ b/arch/arm/configs/phy3250_defconfig
@@ -0,0 +1,89 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_ARCH_LPC32XX=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="console=tty0 console=ttyS0,115200n81 root=/dev/ram0 init=/sbin/init"
+CONFIG_CPU_IDLE=y
+CONFIG_FPE_NWFPE=y
+CONFIG_VFP=y
+CONFIG_BINFMT_AOUT=y
+CONFIG_PM=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FW_LOADER is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_EEPROM_AT25=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_SPI=y
+CONFIG_SPI_PL022=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_FB=y
+CONFIG_FB_ARMCLCD=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_CRAMFS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_FTRACE is not set
+# CONFIG_ARM_UNWIND is not set
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_ERRORS=y
+CONFIG_DEBUG_LL=y
+CONFIG_CRYPTO_ANSI_CPRNG=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
-- 
1.7.1.1
