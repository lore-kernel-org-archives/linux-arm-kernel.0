From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 18:25:52 +0100
Subject: [PATCH/WIP/RFC 06/14] shmobile-iommu: Sort header files alphabetically
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1355678760-27357-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-iommu.c |   10 +++++-----
 drivers/iommu/shmobile-ipmmu.c |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index bbbf1bc..9f2243e3 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -17,14 +17,14 @@
  *
  */
 
-#include <linux/io.h>
+#include <asm/dma-iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
+#include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <mach/ipmmu.h>
-#include <asm/dma-iommu.h>
 
 #define L1_SIZE CONFIG_SHMOBILE_IOMMU_L1SIZE
 #define L1_LEN (L1_SIZE / 4)
diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index d6df0b4..edec3b8 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -17,10 +17,10 @@
  *
  */
 
-#include <linux/platform_device.h>
-#include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <mach/ipmmu.h>
 
-- 
1.7.8.6
