From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 26 Aug 2012 09:49:58 +0800
Subject: [PATCH] ARM: mach-shmobile: remove duplicated include from
 board-ag5evm.c
Message-ID: <CAPgLHd_LaGpVqgWa-5EfYbkmjuM_rhT47y2-z6E3ExZ8Rmw4vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-shmobile/board-ag5evm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index d82c010..cfc3b5c 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -40,7 +40,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
-#include <linux/videodev2.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
