From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  4 Nov 2013 06:19:26 +0100
Subject: [PATCH] ARM: imx: removed unused MACH_MXLADS Kconfig parameter
Message-ID: <1383542366-6270-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the MACH_MXLADS Kconfig parameter,
which was no longer used anywhere in the source code
and Makefiles.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-imx/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6922a8..d84a772bbc68 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -158,14 +158,11 @@ config	SOC_IMX51
 if ARCH_MULTI_V4T
 
 comment "MX1 platforms:"
-config MACH_MXLADS
-	bool
 
 config ARCH_MX1ADS
 	bool "MX1ADS platform"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select MACH_MXLADS
 	select SOC_IMX1
 	help
 	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
-- 
1.8.1.2
