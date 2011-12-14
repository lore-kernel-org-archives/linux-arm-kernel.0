From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Dec 2011 10:16:03 -0500
Subject: [PATCH V3 6/6] ARM: S3C64XX: Modified according to SPI consolidation
 work.
In-Reply-To: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
References: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
Message-ID: <1323875763-21197-7-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the s3c6410 varient SoCs.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index dea62bf..e9dae91 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -281,6 +281,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
 	select S3C_DEV_USB_HOST
@@ -291,7 +292,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_I2C1
 	select S3C_DEV_WDT
 	select S3C_DEV_RTC
-	select S3C64XX_DEV_SPI
+	select S3C64XX_DEV_SPI0
 	select SAMSUNG_GPIO_EXTRA128
 	select I2C
 	help
-- 
1.7.0.4
