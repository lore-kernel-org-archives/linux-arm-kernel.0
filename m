From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  6 Nov 2014 09:07:38 +0100
Subject: [PATCH 1/2] ARM: update Nomadik config
Message-ID: <1415261258-4158-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Nomadik (NHK8815) defconfig to what saveconfig
produces after some recent changes to Kconfig fragments here
and there.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 263ae3869e32..783f44c0dfc6 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -20,7 +20,6 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -57,14 +56,12 @@ CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_GENERIC=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
@@ -89,15 +86,12 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_NOMADIK=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
-CONFIG_I2C_NOMADIK=y
 CONFIG_DEBUG_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
@@ -125,12 +119,12 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
+CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DES=y
-- 
1.9.3
