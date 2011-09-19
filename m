From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Sep 2011 20:36:26 +0900
Subject: [PATCH] ARM: SAMSUNG: Cleanup mach/clkdev.h
Message-ID: <002001cc76c0$5e236c80$1a6a4580$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to commit a3831cf ("ARM: Consolidate the
clkdev header files"), current mach/clkdev.h is no
needed in Samsung stuff.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/clkdev.h |    7 -------
 arch/arm/mach-s3c64xx/include/mach/clkdev.h |    7 -------
 arch/arm/mach-s5p64x0/include/mach/clkdev.h |    7 -------
 arch/arm/mach-s5pc100/include/mach/clkdev.h |    7 -------
 arch/arm/mach-s5pv210/include/mach/clkdev.h |    7 -------
 arch/arm/plat-s3c24xx/include/mach/clkdev.h |    7 -------
 6 files changed, 0 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-s3c24xx/include/mach/clkdev.h

diff --git a/arch/arm/mach-exynos4/include/mach/clkdev.h
b/arch/arm/mach-exynos4/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/mach-exynos4/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/clkdev.h
b/arch/arm/mach-s3c64xx/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
diff --git a/arch/arm/mach-s5p64x0/include/mach/clkdev.h
b/arch/arm/mach-s5p64x0/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/mach-s5p64x0/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
diff --git a/arch/arm/mach-s5pc100/include/mach/clkdev.h
b/arch/arm/mach-s5pc100/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/mach-s5pc100/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
diff --git a/arch/arm/mach-s5pv210/include/mach/clkdev.h
b/arch/arm/mach-s5pv210/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/mach-s5pv210/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
diff --git a/arch/arm/plat-s3c24xx/include/mach/clkdev.h
b/arch/arm/plat-s3c24xx/include/mach/clkdev.h
deleted file mode 100644
index 7dffa83..0000000
--- a/arch/arm/plat-s3c24xx/include/mach/clkdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __MACH_CLKDEV_H__
-#define __MACH_CLKDEV_H__
-
-#define __clk_get(clk) ({ 1; })
-#define __clk_put(clk) do {} while (0)
-
-#endif
-- 
1.7.1
