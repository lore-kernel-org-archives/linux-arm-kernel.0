From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 22 Sep 2010 20:40:57 +0200
Subject: [PATCH] update OMAP Kconfig help texts for all supported SoC models
Message-ID: <20100922184057.GR27439@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 553b7cf..15b603c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,7 +813,7 @@ config ARCH_OMAP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
-	  Support for TI's OMAP platform (OMAP1 and OMAP2).
+	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
 config PLAT_SPEAR
 	bool "ST SPEAr"
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e39a417..d98c5c0 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -19,7 +19,7 @@ config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
 	select COMMON_CLKDEV
 	help
-	  "Systems based on omap24xx, omap34xx or omap44xx"
+	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
 endchoice

---
