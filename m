From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri,  3 Oct 2014 17:53:18 +0200
Subject: [PATCH] mmc: sunxi: Remove unused includes of linux/clk-private.h
Message-ID: <1412351606-29453-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/mmc/host/sunxi-mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 024f67c..647955d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -21,7 +21,6 @@
 #include <linux/err.h>
 
 #include <linux/clk.h>
-#include <linux/clk-private.h>
 #include <linux/clk/sunxi.h>
 
 #include <linux/gpio.h>
-- 
1.9.3
