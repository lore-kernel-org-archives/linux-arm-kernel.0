From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed,  4 May 2011 17:43:54 +0200
Subject: [PATCH] arm: mach-imx/mxs: drop 'default' boards
Message-ID: <1304523834-21908-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No boards should be compiled in by default.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Based on for-imx-2.6.40

 arch/arm/mach-imx/Kconfig |    2 --
 arch/arm/mach-mxs/Kconfig |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0382301..b41d061 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -342,7 +342,6 @@ config MACH_MX31ADS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
-	default y
 	help
 	  Include support for MX31ADS platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -490,7 +489,6 @@ config MACH_BUG
 	bool "Support Buglabs BUGBase platform"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
-	default y
 	help
 	  Include support for BUGBase 1.3 platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4522fbb..21de5d5 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -24,7 +24,6 @@ config MACH_MX23EVK
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
-	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -39,7 +38,6 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_OCOTP
-	default y
 	help
 	  Include support for MX28EVK platform. This includes specific
 	  configurations for the board and its peripherals.
-- 
1.7.2.5
