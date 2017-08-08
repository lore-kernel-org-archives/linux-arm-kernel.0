From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue,  8 Aug 2017 17:36:36 +0200
Subject: [PATCH] ARM: sunxi: add an help section to the Kconfig Sun8i SoC
 selection
Message-ID: <20170808153636.26846-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since sun8i regroup lots of SoCs, it is helpful to list them in the help
section of Kconfig.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 58153cdf025b..2ffcccda2688 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -42,6 +42,9 @@ config MACH_SUN8I
 	default ARCH_SUNXI
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
+	help
+	  Select this option if you have one of the following SoC:
+	  A23 A33 A83T H2+ H3 R16 V3S
 
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
-- 
2.13.0
