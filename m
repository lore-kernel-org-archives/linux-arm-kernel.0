From: weiyj_lk@163.com (Wei Yongjun)
Date: Tue, 19 Jul 2016 11:27:09 +0000
Subject: [PATCH -next] ARM: ux500: remove duplicated include from cpu-db8500.c
Message-ID: <1468927629-32715-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-ux500/cpu-db8500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 46b1da1..c0c36b97 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
