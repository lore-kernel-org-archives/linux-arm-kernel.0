From: kostap@marvell.com (Konstantin Porotchkin)
Date: Thu,  7 Apr 2011 13:49:42 +0300
Subject: [PATCH 2/2] Sync Marvell Dove defconfig with latest kernel
In-Reply-To: <1302173382-25577-1-git-send-email-kostap@marvell.com>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
Message-ID: <1302173382-25577-2-git-send-email-kostap@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-generate defconfig for Marvell Dove platform

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm/configs/dove_defconfig |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index d7c3cfa..40db34c 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -42,7 +42,6 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
-# CONFIG_MISC_DEVICES is not set
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -57,12 +56,12 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -70,12 +69,10 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MV=y
@@ -84,7 +81,6 @@ CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-CONFIG_INOTIFY=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_UDF_FS=m
@@ -108,23 +104,19 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_BLOWFISH=y
-CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
-- 
1.7.4.1
