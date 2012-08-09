From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  9 Aug 2012 15:35:33 +0200
Subject: [PATCH] ARM: imx/imx31-dt: drop selecting USE_OF
Message-ID: <1344519333-6446-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

since commit
	3e62af8 (ARM: imx: select USE_OF)
ARM_MXC already selects USE_OF, so there is no need to repeat it for
MACH_IMX31_DT

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 419c292..6152a84 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -561,7 +561,6 @@ config MACH_BUG
 config MACH_IMX31_DT
 	bool "Support i.MX31 platforms from device tree"
 	select SOC_IMX31
-	select USE_OF
 	help
 	  Include support for Freescale i.MX31 based platforms
 	  using the device tree for discovery.
-- 
1.7.10.4
