From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 19 Jun 2013 16:15:18 -0700
Subject: [PATCH] ARM: bcm281xx: Turn on L2 cache.
Message-ID: <1371683718-15026-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turning on the L2 cache for the bcm281xx family.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Acked-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f112895..69d67f7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -12,6 +12,7 @@ config ARCH_BCM
 	select GPIO_BCM
 	select SPARSE_IRQ
 	select TICK_ONESHOT
+	select CACHE_L2X0
 	help
 	  This enables support for system based on Broadcom SoCs.
 	  It currently supports the 'BCM281XX' family, which includes
-- 
1.7.9.5
