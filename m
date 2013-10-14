From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 14 Oct 2013 14:41:59 -0700
Subject: [PATCH] ARM: bcm_defconfig: Run "make savedefconfig"
Message-ID: <1381786919-31286-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several of the options in bcm_defconfig have gotten out of date so
regenerate it with "make savedefconfig" to keep things fresh.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index efb0132..3a138af 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
@@ -25,11 +24,8 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ARCH_BCM=y
-CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_ARM_THUMBEE=y
-CONFIG_ARM_ERRATA_743622=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
@@ -51,7 +47,6 @@ CONFIG_UNIX_DIAG=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
-CONFIG_ARPD=y
 CONFIG_SYN_COOKIES=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
@@ -96,7 +91,6 @@ CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_TEST=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -118,12 +112,12 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
-CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
-- 
1.8.0.1
