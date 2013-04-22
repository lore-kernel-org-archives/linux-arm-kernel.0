From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 22 Apr 2013 12:39:56 +0800
Subject: [PATCH -next] ARM: vexpress: remove duplicated include from v2m.c
Message-ID: <CAPgLHd-hTihxfc8CS2E2ZsfwFHf7oN5o4oicWOXo_dwcFhg2kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-vexpress/v2m.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index b6083bb..d07048c 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -6,7 +6,6 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
-#include <linux/clocksource.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
