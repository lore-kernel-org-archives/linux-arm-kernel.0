From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 20 Jun 2013 08:01:05 +0800
Subject: [PATCH -next] ARM: OMAP2+: devices: remove duplicated include from
 devices.c
Message-ID: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/devices.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c0f99ab..8349238 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
