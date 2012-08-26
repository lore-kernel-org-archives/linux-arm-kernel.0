From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 26 Aug 2012 09:49:34 +0800
Subject: [PATCH] ARM: mxs: remove duplicated include from mach-mxs.c
Message-ID: <CAPgLHd_QDRHKBybnCtD_K-JJvJG_f4x6wTXczQZqraiLch4wEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-mxs/mach-mxs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8dabfe8..5c91870 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -14,7 +14,6 @@
 #include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/micrel_phy.h>
 #include <linux/mxsfb.h>
