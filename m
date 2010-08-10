From: joe@perches.com (Joe Perches)
Date: Mon,  9 Aug 2010 23:46:28 -0700
Subject: [PATCH] MAINTAINERS: Update ARM/S3C patterns
Message-ID: <28b93faea32a3f5a3f79a68b92c60ba7dad99425.1281422516.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for merged SOCs

Signed-off-by: Joe Perches <joe@perches.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 MAINTAINERS |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 832f904..13a6d02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -908,20 +908,13 @@ W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/mach-s3c2410/
 
-ARM/S3C2440 ARM ARCHITECTURE
+ARM/S3C2440 and S3C2442 ARM ARCHITECTURE
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/mach-s3c2440/
 
-ARM/S3C2442 ARM ARCHITECTURE
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
-S:	Maintained
-F:	arch/arm/mach-s3c2442/
-
 ARM/S3C2443 ARM ARCHITECTURE
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -929,19 +922,12 @@ W:	http://www.fluff.org/ben/linux/
 S:	Maintained
 F:	arch/arm/mach-s3c2443/
 
-ARM/S3C6400 ARM ARCHITECTURE
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.fluff.org/ben/linux/
-S:	Maintained
-F:	arch/arm/mach-s3c6400/
-
-ARM/S3C6410 ARM ARCHITECTURE
+ARM/S3C64xx ARM ARCHITECTURE
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.fluff.org/ben/linux/
 S:	Maintained
-F:	arch/arm/mach-s3c6410/
+F:	arch/arm/mach-s3c64xx/
 
 ARM/SHMOBILE ARM ARCHITECTURE
 M:	Paul Mundt <lethal@linux-sh.org>
-- 
1.7.2.19.g9a302
