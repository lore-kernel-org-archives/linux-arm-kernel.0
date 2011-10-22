From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 23 Oct 2011 00:12:14 +0200
Subject: [RFC][PATCH] Consolidate Samsung MAINTAINERS
Message-ID: <201110230012.15273.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These days most Samsung stuff gets in the kernel through Kukjin Kim.
This patch changes MAINTAINERS to reflect this.

By adding Kukjin Kim to the maintainers for S3C2410, S3C244x and
S3C64xx alongside Ben Dooks the extra entries become identical to the
base ARM/SAMSUNG entry and can move into it.

Also the S3C2416 gets a maintainer through the s3c24* wildcard - as it
did not have one until now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d9b9d5..6646316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1032,30 +1032,10 @@ S:	Maintained
 F:	arch/arm/plat-samsung/
 F:	arch/arm/plat-s3c24xx/
 F:	arch/arm/plat-s5p/
+F:	arch/arm/mach-s3c24*/
+F:	arch/arm/mach-s3c64xx/
 F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
-
-ARM/S3C2410 ARM ARCHITECTURE
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
-S:	Maintained
-F:	arch/arm/mach-s3c2410/
-
-ARM/S3C244x ARM ARCHITECTURE
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
-S:	Maintained
-F:	arch/arm/mach-s3c2440/
-F:	arch/arm/mach-s3c2443/
-
-ARM/S3C64xx ARM ARCHITECTURE
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
-S:	Maintained
-F:	arch/arm/mach-s3c64xx/
 
 ARM/S5P EXYNOS ARM ARCHITECTURES
 M:	Kukjin Kim <kgene.kim@samsung.com>
-- 
1.7.2.3
