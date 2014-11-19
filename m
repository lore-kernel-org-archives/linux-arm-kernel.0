From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 19 Nov 2014 12:15:46 +0100
Subject: [PATCH v3 17/19] iommu: exynos: remove excessive includes and sort
 others alphabetically
In-Reply-To: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1416395748-10731-18-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed following unused includes: <linux/mm.h>, <linux/errno.h>,
<linux/memblock.h> and <linux/export.h>.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a5b32cdeec2d..cd28dc09db39 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -12,19 +12,15 @@
 #define DEBUG
 #endif
 
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/mm.h>
+#include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/list.h>
-#include <linux/memblock.h>
-#include <linux/export.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
-- 
1.9.2
