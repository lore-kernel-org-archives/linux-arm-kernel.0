From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:26:48 +0200
Subject: [PATCH] mmc: atmel-mci: remove useless include
Message-ID: <1439216808-11826-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definitions from linux/platform_data/atmel.h are not used, remove the
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mmc/host/atmel-mci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9a39e0b7e583..bf62e429f7fc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/types.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/platform_data/mmc-atmel-mci.h>
 
 #include <linux/mmc/host.h>
-- 
2.1.4
