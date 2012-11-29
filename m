From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 28 Nov 2012 21:45:51 -0500
Subject: [PATCH -next] ARM: OMAP4: remove duplicated include from
 omap_hwmod_44xx_data.c
Message-ID: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e5eda55..f13fdbb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -26,7 +26,6 @@
 
 #include <plat-omap/dma-omap.h>
 
-#include <linux/platform_data/omap_ocp2scp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/dmtimer.h>
