From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 4 Dec 2012 03:29:14 -0500
Subject: [PATCH -next] ARM: EXYNOS: remove duplicated include from
 mach-exynos5-dt.c
Message-ID: <CAPgLHd9_QOV0GA3b2h7dTXQS7P17cP0mw2iD_KsEZYpPtwu8RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 45988fd..087f2df 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,7 +14,6 @@
 #include <linux/serial_core.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
-#include <linux/of_fdt.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
