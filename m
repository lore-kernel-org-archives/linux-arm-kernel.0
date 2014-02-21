From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Feb 2014 10:52:33 -0300
Subject: [PATCH] ARM: mach-imx: Kconfig: Remove IMX_HAVE_PLATFORM_IMX2_WDT
 from SOC_IMX53
Message-ID: <1392990753-9869-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SOC_IMX53 is a device-tree only platform, so we don't need 
IMX_HAVE_PLATFORM_IMX2_WDT at all.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 04aa1de..d75d168 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -780,7 +780,6 @@ config	SOC_IMX50
 config	SOC_IMX53
 	bool "i.MX53 support"
 	select HAVE_IMX_SRC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select PINCTRL_IMX53
 	select SOC_IMX5
 
-- 
1.8.1.2
