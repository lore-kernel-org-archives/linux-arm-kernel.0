From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  9 Apr 2013 08:58:23 +0200
Subject: [PATCH 2/2] ARM: i.MX: remove unused ARCH_* configs
In-Reply-To: <1365490703-1852-1-git-send-email-s.hauer@pengutronix.de>
References: <1365490703-1852-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365490703-1852-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Bolle <pebolle@tiscali.nl>

This removes the unused Kconfig options ARCH_MX5, ARCH_MX51,
ARCH_MX53 and MACH_MX21.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4c9c6f9..6575e4e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -83,24 +83,12 @@ config ARCH_MXC_IOMUX_V3
 config ARCH_MX1
 	bool
 
-config MACH_MX21
-	bool
-
 config ARCH_MX25
 	bool
 
 config MACH_MX27
 	bool
 
-config ARCH_MX5
-	bool
-
-config ARCH_MX51
-	bool
-
-config ARCH_MX53
-	bool
-
 config SOC_IMX1
 	bool
 	select ARCH_MX1
@@ -114,7 +102,6 @@ config SOC_IMX21
 	select COMMON_CLK
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
-	select MACH_MX21
 	select MXC_AVIC
 
 config SOC_IMX25
@@ -155,7 +142,6 @@ config SOC_IMX35
 config SOC_IMX5
 	bool
 	select ARCH_HAS_CPUFREQ
-	select ARCH_MX5
 	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
 	select CPU_V7
@@ -163,8 +149,6 @@ config SOC_IMX5
 
 config	SOC_IMX51
 	bool
-	select ARCH_MX5
-	select ARCH_MX51
 	select PINCTRL
 	select PINCTRL_IMX51
 	select SOC_IMX5
@@ -789,8 +773,6 @@ comment "Device tree only"
 
 config	SOC_IMX53
 	bool "i.MX53 support"
-	select ARCH_MX5
-	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select PINCTRL
-- 
1.8.2.rc2
