From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 16:50:37 -0500
Subject: [PATCH v3 04/23] mm/memblock: remove unnecessary inclusions of
 bootmem.h
In-Reply-To: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386625856-12942-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Clean-up to remove depedency with bootmem headers.

Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/char/mem.c  |    1 -
 mm/memory_hotplug.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f895a8c..92c5937 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -22,7 +22,6 @@
 #include <linux/device.h>
 #include <linux/highmem.h>
 #include <linux/backing-dev.h>
-#include <linux/bootmem.h>
 #include <linux/splice.h>
 #include <linux/pfn.h>
 #include <linux/export.h>
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 489f235..cf1736d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -9,7 +9,6 @@
 #include <linux/swap.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
-#include <linux/bootmem.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/pagevec.h>
-- 
1.7.9.5
