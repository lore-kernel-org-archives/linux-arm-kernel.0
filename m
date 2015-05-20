From: stefan@agner.ch (Stefan Agner)
Date: Thu, 21 May 2015 00:38:21 +0200
Subject: [PATCH defconfig] ARM: add ARM_SINGLE_ARMV7M in ARMv7-M defconfigs
Message-ID: <1432161501-2323-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select ARM_SINGLE_ARMV7M in defconfigs of the converted ARMv7-M
platforms.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/efm32_defconfig   | 2 +-
 arch/arm/configs/lpc18xx_defconfig | 1 +
 arch/arm/configs/stm32_defconfig   | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index c4c17e3..c0dac0f0f 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -16,6 +16,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
+CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_EFM32=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x88000000
@@ -85,7 +86,6 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
-# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index caf7b52..d4320a7 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -22,6 +22,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
+CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_LPC18XX=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x28000000
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index fab9cf9..4725fab 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -18,6 +18,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
+CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_STM32=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
-- 
2.4.1
