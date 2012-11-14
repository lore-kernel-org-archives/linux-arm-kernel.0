From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Nov 2012 16:52:09 +0900
Subject: [PATCH] ARM: S3C64XX: Add missing device selects for Cragganmore
Message-ID: <1352879529-7057-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously unnoticed due to selection by other machines.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 63e7ae3..131c862 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -294,6 +294,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SPI
 	select S3C64XX_SETUP_USB_PHY
+	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
@@ -304,6 +305,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_WDT
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
 	select SAMSUNG_GPIO_EXTRA128
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
-- 
1.7.10.4
