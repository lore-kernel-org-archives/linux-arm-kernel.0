From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Fri, 17 Jun 2016 17:21:16 +0000
Subject: [PATCH -next] mtd: mtk-nor: remove duplicated include from
 mtk-quadspi.c
Message-ID: <1466184076-11714-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 21c31b3..e661877 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -21,7 +21,6 @@
 #include <linux/ioport.h>
 #include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/mtd/mtd.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
