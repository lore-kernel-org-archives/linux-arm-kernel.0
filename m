From: stigge@antcom.de (Roland Stigge)
Date: Thu, 25 Oct 2012 13:28:33 +0200
Subject: [PATCH] watchdog: Support imx watchdog on SOC_IMX53
Message-ID: <1351164513-27999-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes watchdog support after devicetree switch for imx53

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/arch/arm/mach-imx/Kconfig
+++ linux-2.6/arch/arm/mach-imx/Kconfig
@@ -739,6 +739,7 @@ config	SOC_IMX53
 	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select PINCTRL
 	select PINCTRL_IMX53
 	select SOC_IMX5
