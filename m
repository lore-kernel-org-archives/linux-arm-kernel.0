From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Jul 2011 12:17:22 +0800
Subject: linux-next: merge error in arch/arm/mm/Kconfig?
Message-ID: <20110725041720.GA21641@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a merge error (?) causing 'make ARCH=arm menuconfig' fails on
next-20110722.

---8<-------------
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d490c4a..2df5504 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -834,7 +834,7 @@ config CACHE_L2X0
        depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
                   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
                   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-                  ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE ||
+                  ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
                   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX
        default y
        select OUTER_CACHE


-- 
Regards,
Shawn
