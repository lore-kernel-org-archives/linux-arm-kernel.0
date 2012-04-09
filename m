From: olof@lixom.net (Olof Johansson)
Date: Sun,  8 Apr 2012 21:33:13 -0700
Subject: [PATCH] ARM: exynos: add dts files to dtbs target
Message-ID: <1333945993-20363-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the currently in-tree device tree sources to the dtbs target.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-exynos/Makefile.boot |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
index b9862e2..31bd181 100644
--- a/arch/arm/mach-exynos/Makefile.boot
+++ b/arch/arm/mach-exynos/Makefile.boot
@@ -1,2 +1,5 @@
    zreladdr-y	+= 0x40008000
 params_phys-y	:= 0x40000100
+
+dtb-$(CONFIG_MACH_EXYNOS4_DT) += exynos4210-origen.dtb exynos4210-smdkv310.dtb
+dtb-$(CONFIG_MACH_EXYNOS5_DT) += exynos5250-smdk5250.dtb
-- 
1.7.9.2.359.gebfc2
