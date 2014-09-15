From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Sep 2014 16:15:09 -0500
Subject: [PATCH 9/9] irqchip: omap-intc: remove unnecessary comments
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Message-ID: <1410815709-462-10-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no fuctional changes.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 976d4c1..f3814e7 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -56,14 +56,6 @@
 
 #define INTC_PROTECTION_ENABLE	(1 << 0)
 
-/*
- * OMAP2 has a number of different interrupt controllers, each interrupt
- * controller is identified as its own "bank". Register definitions are
- * fairly consistent for each bank, but not all registers are implemented
- * for each bank.. when in doubt, consult the TRM.
- */
-
-/* Structure to save interrupt controller context */
 struct omap_intc_regs {
 	u32 sysconfig;
 	u32 protection;
@@ -79,7 +71,6 @@ static void __iomem *omap_irq_base;
 static int omap_nr_pending = 3;
 static int omap_nr_irqs = 96;
 
-/* INTC bank register get/set */
 static void intc_writel(u32 reg, u32 val)
 {
 	writel_relaxed(val, omap_irq_base + reg);
-- 
2.0.1.563.g66f467c
