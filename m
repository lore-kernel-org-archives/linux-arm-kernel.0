From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 15:26:16 +0900
Subject: [PATCH] ARM: mach-shmobile: remove duplicated include from
 board-ag5evm.c
In-Reply-To: <1346394376-11951-1-git-send-email-horms@verge.net.au>
References: <1346394376-11951-1-git-send-email-horms@verge.net.au>
Message-ID: <1346394376-11951-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Simon Horman <horms@verge.net.au>
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
-- 
1.7.10.2.484.gcd07cc5
