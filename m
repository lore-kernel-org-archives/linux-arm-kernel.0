From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Feb 2012 09:16:30 +0900
Subject: Subject: [PATCH] MAINTAINERS: add maintainer entry for SAMSUNG EXYNOS
 DeviceTree
Message-ID: <00f301ccf0f7$39f222a0$add667e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Samsung EXYNOS DT maintainer

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a648eb..5ac5aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,6 +1065,16 @@ S:	Maintained
 F:	arch/arm/mach-s5p*/
 F:	arch/arm/mach-exynos*/
 
+ARM/SAMSUNG EXYNOS DEVICE TREE
+M:	Thomas Abraham <thomas.abraham@linaro.org>
+M:	Kukjin Kim <kgene.kim@samsung.com>
+L:	devicetree-discuss at lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/exynos*
+F:	arch/arm/mach-exynos/*dt.c
+F:	Documentation/devicetree/*/*/*samsung*
+
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.1
