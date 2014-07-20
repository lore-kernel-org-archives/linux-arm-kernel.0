From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sun, 20 Jul 2014 22:01:24 +0800
Subject: [PATCH -next] spi/rockchip: remove duplicated include from
 spi-rockchip.c
Message-ID: <1405864884-13981-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 72fb287..d697381 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -26,7 +26,6 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/io.h>
-#include <linux/scatterlist.h>
 #include <linux/dmaengine.h>
 
 #define DRIVER_NAME "rockchip-spi"
