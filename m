From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 7 Oct 2012 21:25:34 +0800
Subject: [PATCH] ARM: sa11x0: remove duplicated include from hackkit.c
Message-ID: <CAPgLHd_a8ne_UXQfBr2cfkVffRUV5qcN_ndcPKJu1QAs1zd_Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index fc106aa..d67a6d3 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -21,7 +21,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
