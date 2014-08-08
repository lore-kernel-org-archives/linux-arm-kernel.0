From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Fri, 8 Aug 2014 18:17:13 -0500
Subject: [PATCH 1/4] irqchip: gic-v2m: Remove irq-gic-v2m.h file
In-Reply-To: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1407539836-9768-2-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Remove irq-gic-v2m.h file which is no longer used

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-gic-v2m.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.h b/drivers/irqchip/irq-gic-v2m.h
index 2d93a87..e69de29 100644
--- a/drivers/irqchip/irq-gic-v2m.h
+++ b/drivers/irqchip/irq-gic-v2m.h
@@ -1,13 +0,0 @@
-#ifndef _IRQ_GIC_V2M_H_
-#define _IRQ_GIC_V2M_H_
-
-struct v2m_data {
-	spinlock_t msi_cnt_lock;
-	struct resource res;      /* GICv2m resource */
-	void __iomem *base;       /* GICv2m virt address */
-	unsigned int spi_start;   /* The SPI number that MSIs start */
-	unsigned int nr_spis;     /* The number of SPIs for MSIs */
-	unsigned long *bm;        /* MSI vector bitmap */
-};
-
-#endif /*_IRQ_GIC_V2M_H_*/
-- 
1.9.0
