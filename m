From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 Feb 2015 12:47:46 -0300
Subject: [PATCH] ARM: imx: Kconfig: Fix grammar in help text
Message-ID: <1425138466-19823-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Use "This enables" in the Kconfig help text to fix grammar.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index aaea738..247a465 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -621,7 +621,7 @@ config SOC_VF610
 	select PL310_ERRATA_769419 if CACHE_L2X0
 
 	help
-	  This enable support for Freescale Vybrid VF610 processor.
+	  This enables support for Freescale Vybrid VF610 processor.
 
 choice
 	prompt "Clocksource for scheduler clock"
@@ -651,7 +651,7 @@ config SOC_LS1021A
 	select ZONE_DMA if ARM_LPAE
 
 	help
-	  This enable support for Freescale LS1021A processor.
+	  This enables support for Freescale LS1021A processor.
 
 endif
 
-- 
1.9.1
