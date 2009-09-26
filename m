From: jaswinder@kernel.org (Jaswinder Singh Rajput)
Date: Sat, 26 Sep 2009 19:41:43 +0530
Subject: [PATCH] ARM: OMAP: Remove unused CONFIG MACH_OMAP_HTCWIZARD
Message-ID: <1253974303.4568.13.camel@ht.satnam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Remove unused CONFIG MACH_OMAP_HTCWIZARD from Kconfig

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
Cc: Zebediah C. McClure <zmc@lurian.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
---
 arch/arm/mach-omap1/Kconfig |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 55ecc01..c25038e 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -50,12 +50,6 @@ config MACH_OMAP_H3
 	  TI OMAP 1710 H3 board support. Say Y here if you have such
 	  a board.
 
-config MACH_OMAP_HTCWIZARD
-	bool "HTC Wizard"
-	depends on ARCH_OMAP850
-	help
-	  HTC Wizard smartphone support (AKA QTEK 9100, ...)
-
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-- 
1.6.0.6
