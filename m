From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:28:07 +0200
Subject: [PATCH] spi: atmel: remove useless include
Message-ID: <1439216887-11985-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definitions from linux/platform_data/atmel.h are not used, remove the
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/spi/spi-atmel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c9eca347787d..bf9ed380bb1c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <linux/of.h>
 
-- 
2.1.4
