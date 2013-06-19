From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 20 Jun 2013 07:43:29 +0800
Subject: [PATCH -next] ARM: OMAP1: remove duplicated include from
 board-voiceblue.c
Message-ID: <CAPgLHd8t3h03XAzgge8aif-fkGBxqE21hDfThh6neF0WzKJK3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap1/board-voiceblue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 4677a9c..4b382a0 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -26,7 +26,6 @@
 #include <linux/serial_reg.h>
 #include <linux/smc91x.h>
 #include <linux/export.h>
-#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
