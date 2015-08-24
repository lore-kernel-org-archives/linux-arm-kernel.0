From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 24 Aug 2015 11:45:15 +0800
Subject: [PATCH v3 1/4] spi: mediatek: add linux/io.h include file
In-Reply-To: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440387918-22191-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mediatek spi driver uses readl/writel, so add linux/io.h,
even so it's implicitly imported by spi/spi.h

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 43c1dd5..fe4eda3 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
1.8.1.1.dirty
