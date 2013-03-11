From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 11 Mar 2013 22:12:53 +0800
Subject: [PATCH -next] ARM: EXYNOS: remove duplicated include from common.c
Message-ID: <CAPgLHd9eSiAne_f_8ctbXt8x+ET3v_1o=-gdO1D_11kxx2jo3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-exynos/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index d63d399..01e4089 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -23,7 +23,6 @@
 #include <linux/of_irq.h>
 #include <linux/export.h>
 #include <linux/irqdomain.h>
-#include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/irqchip/arm-gic.h>
 
