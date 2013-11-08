From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 8 Nov 2013 18:41:40 -0500
Subject: [PATCH 04/24] mm/block: remove unnecessary inclusion of bootmem.h
In-Reply-To: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1383954120-24368-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Clean-up to remove depedency with bootmem headers.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 block/blk-ioc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 46cd7bd..242df01 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
-#include <linux/bootmem.h>	/* for max_pfn/max_low_pfn */
 #include <linux/slab.h>
 
 #include "blk.h"
-- 
1.7.9.5
