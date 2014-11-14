From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 14 Nov 2014 16:54:57 +0900
Subject: [PATCH] MAINTAINERS: update email address and cleanup for exynos entry
Message-ID: <1415951697-5991-1-git-send-email-kgene@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use kernel.org account instead of samsung.com and cleanup for Samsung
s3c, s5p and exynos SoCs.

Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
---
 MAINTAINERS |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1163..b1e27bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1308,30 +1308,22 @@ F:	drivers/*/*rockchip*
 F:	drivers/*/*/*rockchip*
 F:	sound/soc/rockchip/
 
-ARM/SAMSUNG ARM ARCHITECTURES
-M:	Ben Dooks <ben-linux@fluff.org>
-M:	Kukjin Kim <kgene.kim@samsung.com>
+ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
+M:	Kukjin Kim <kgene@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/exynos*
 F:	arch/arm/plat-samsung/
 F:	arch/arm/mach-s3c24*/
 F:	arch/arm/mach-s3c64xx/
+F:	arch/arm/mach-s5p*/
+F:	arch/arm/mach-exynos*/
 F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
 F:	drivers/spi/spi-s3c*
 F:	sound/soc/samsung/*
-
-ARM/S5P EXYNOS ARM ARCHITECTURES
-M:	Kukjin Kim <kgene.kim@samsung.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-s5p*/
-F:	arch/arm/mach-exynos*/
 N:	exynos
 
 ARM/SAMSUNG MOBILE MACHINE SUPPORT
-- 
1.7.4.4
