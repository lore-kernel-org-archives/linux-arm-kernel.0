From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 30 Oct 2013 13:38:34 +0800
Subject: [PATCH -next] ARM i.MX53: remove duplicated include from
 clk-imx51-imx53.c
Message-ID: <CAPgLHd9smv2Jcb7SUxKsXHqnDos53A3ZhVWPMSyDJckR9_URKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index ce37af2..2828ea65 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
-#include <linux/of.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
