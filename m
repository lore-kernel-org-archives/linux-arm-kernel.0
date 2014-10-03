From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri,  3 Oct 2014 17:52:46 +0200
Subject: [PATCH] clk: ux500: Remove unused includes of linux/clk-private.h
Message-ID: <1412351566-29344-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/ux500/clk-prcc.c  | 1 -
 drivers/clk/ux500/clk-prcmu.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index bd4769a..0e95076 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clk-private.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index e2d63bc..bf63c96 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clk-private.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-- 
1.9.3
