From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 26 Aug 2012 09:48:11 +0800
Subject: [PATCH] ARM i.MX: remove duplicated include from clk-imx21.c
Message-ID: <CAPgLHd_pYM3otnZBZ=nz7aYTP4dorBSjQtj=x9Z+zz7yr1NgSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-imx/clk-imx21.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index ea13e61..cf65148 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -23,7 +23,6 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/clkdev.h>
 #include <linux/err.h>
 
 #include <mach/hardware.h>
