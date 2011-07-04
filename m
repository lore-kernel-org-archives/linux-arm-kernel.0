From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Jul 2011 13:42:24 -0400
Subject: [PATCH] ARM: SAMSUNG: Added SPI machine support
Message-ID: <1309801344-27588-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added SPI machine support in SMDK6410,SMDKC100,SMDKV210

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig |    1 +
 arch/arm/mach-s5pc100/Kconfig |    1 +
 arch/arm/mach-s5pv210/Kconfig |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 4e2c371..ba36abc 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -150,6 +150,7 @@ config MACH_SMDK6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_DEV_SPI
 	help
 	  Machine support for the Samsung SMDK6410
 
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 608722f..ceca59f 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -68,6 +68,7 @@ config MACH_SMDKC100
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
+	select S3C64XX_DEV_SPI
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 37b5a97..2871ff2 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -144,6 +144,7 @@ config MACH_SMDKV210
 	select S5PV210_SETUP_IDE
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
+	select S3C64XX_DEV_SPI
 	help
 	  Machine support for Samsung SMDKV210
 
-- 
1.7.0.4
