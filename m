From: pravin.shedge4linux@gmail.com (Pravin Shedge)
Date: Tue,  5 Dec 2017 07:30:09 +0530
Subject: [PATCH 05/45] drivers: hwtracing: remove duplicate includes
Message-ID: <1512439209-15661-1-git-send-email-pravin.shedge4linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index e03e589..580cd38 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -33,7 +33,6 @@
 #include <linux/mm.h>
 #include <linux/perf_event.h>
 
-#include <asm/local.h>
 
 #include "coresight-priv.h"
 
-- 
2.7.4
