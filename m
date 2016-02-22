From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 22 Feb 2016 15:33:15 +0530
Subject: [PATCH 2/3] ARM: EXYNOS: remove unused register offset definition
In-Reply-To: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
References: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1456135396-17767-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up map.h by removing unused register offset
and changing EXYNOS4 to EXYNOS in header comment section.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 351e839..c48ba4f 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -2,7 +2,7 @@
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
- * EXYNOS4 - Memory map definitions
+ * EXYNOS - Memory map definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,12 +14,6 @@
 
 #include <plat/map-base.h>
 
-/*
- * EXYNOS4 UART offset is 0x10000 but the older S5P SoCs are 0x400.
- * So need to define it, and here is to avoid redefinition warning.
- */
-#define S3C_UART_OFFSET			(0x10000)
-
 #include <plat/map-s5p.h>
 
 #define EXYNOS_PA_CHIPID		0x10000000
@@ -30,6 +24,5 @@
 #define EXYNOS4_PA_DMC1			0x10410000
 
 #define EXYNOS4_PA_COREPERI		0x10500000
-#define EXYNOS4_PA_L2CC			0x10502000
 
 #endif /* __ASM_ARCH_MAP_H */
-- 
2.4.5
