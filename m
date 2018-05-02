From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 02 May 2018 16:30:26 +0200
Subject: [PATCH] ARM: EXYNOS: no need to select ARCH_HAS_BANDGAP any longer
References: <CGME20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12@eucas1p1.samsung.com>
Message-ID: <9721484.FBO9LEPOs5@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed since commit fcbb1e02ee54 ("drivers: thermal:
Remove ARCH_HAS_BANDGAP dependency for samsung") from 2014.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 -
 1 file changed, 1 deletion(-)

Index: b/arch/arm/mach-exynos/Kconfig
===================================================================
--- a/arch/arm/mach-exynos/Kconfig	2018-03-07 13:57:25.249409707 +0100
+++ b/arch/arm/mach-exynos/Kconfig	2018-05-02 16:23:38.573626832 +0200
@@ -8,7 +8,6 @@
 menuconfig ARCH_EXYNOS
 	bool "Samsung EXYNOS"
 	depends on ARCH_MULTI_V7
-	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
