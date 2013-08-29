From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 Aug 2013 16:29:48 +0530
Subject: [PATCH 1/1] clk: bcm2835: Remove duplicate inclusion of clk-provider.h
Message-ID: <1377773988-32575-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk-provider.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/clk-bcm2835.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index 5fb4ff5..676077d 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -20,7 +20,6 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
-#include <linux/clk-provider.h>
 #include <linux/of.h>
 
 static const struct of_device_id clk_match[] __initconst = {
-- 
1.7.9.5
