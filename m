From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Dec 2017 11:05:45 -0700
Subject: [PATCH 4/4] coresight: etb10: remove duplicate includes
In-Reply-To: <1513620345-1366-1-git-send-email-mathieu.poirier@linaro.org>
References: <1513620345-1366-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1513620345-1366-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pravin Shedge <pravin.shedge4linux@gmail.com>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index e03e58933141..580cd381adf3 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -33,7 +33,6 @@
 #include <linux/mm.h>
 #include <linux/perf_event.h>
 
-#include <asm/local.h>
 
 #include "coresight-priv.h"
 
-- 
2.7.4
