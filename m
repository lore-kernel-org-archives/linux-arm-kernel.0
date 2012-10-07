From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 7 Oct 2012 21:25:03 +0800
Subject: [PATCH] ARM: OMAP2+: remove duplicated include from
 board-omap3stalker.c
Message-ID: <CAPgLHd-DH3T=WxZqSBF0hHAsJbqC2Kw0K-+R9GLT8dtKsFfYjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-omap3stalker.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index c7f3d02..731235e 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -48,11 +48,6 @@
 #include <video/omap-panel-tfp410.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/input/matrix_keypad.h>
-#include <linux/spi/spi.h>
-#include <linux/interrupt.h>
-#include <linux/smsc911x.h>
-#include <linux/i2c/at24.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mux.h"
