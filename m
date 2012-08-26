From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 26 Aug 2012 09:43:00 +0800
Subject: [PATCH] usb: gadget: remove duplicated include from pxa25x_udc.c
Message-ID: <CAPgLHd-CLDf3ki+fX8P_QRLu8ErCQpGbywM2z5SE4xJp6XpePA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/usb/gadget/pxa25x_udc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 907ad3e..c246c08 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -33,7 +33,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
