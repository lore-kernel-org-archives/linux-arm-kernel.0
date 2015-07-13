From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 09:32:51 +0000
Subject: [PATCH 3/3] hwspinlock: sirf: remove useless header files
Message-ID: <1436779971-3232-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

Some header files are useless for atlas7 hwlock driver.
remove them.

Cc: Suman Anna <s-anna@ti.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 692ac41..f35473c 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -6,13 +6,9 @@
  * Licensed under GPLv2.
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/hwspinlock.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-- 
2.3.5
