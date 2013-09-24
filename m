From: csd@broadcom.com (Christian Daudt)
Date: Tue, 24 Sep 2013 13:20:52 -0700
Subject: [PATCH] ARM: bcm281xx: Add ARCH Timers to config
Message-ID: <1380054052-11527-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add HAVE_ARM_ARCH_TIMER to Broadcom Kconfig as it is
required for some Mobile SoCs.

Signed-off-by: Christian Daudt <bcm@fixthebug.org>
Reviewed-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: Mark Hambleton <mahamble@broadcom.com>
Reviewed-by: James King <jamesk@broadcom.com>

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 69d67f7..635537b 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -13,6 +13,7 @@ config ARCH_BCM
 	select SPARSE_IRQ
 	select TICK_ONESHOT
 	select CACHE_L2X0
+	select HAVE_ARM_ARCH_TIMER
 	help
 	  This enables support for system based on Broadcom SoCs.
 	  It currently supports the 'BCM281XX' family, which includes
-- 
1.7.10.4
