From: leochen@broadcom.com (Leo Chen)
Date: Wed, 7 Oct 2009 11:43:55 -0700
Subject: [PATCH] bcmring: add gpio_to_irq and irq_to_gpio functions
Message-ID: <mailman.63.1255122772.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix checkpatch errors for irqs.h

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/mach-bcmring/include/mach/irqs.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/include/mach/irqs.h b/arch/arm/mach-bcmring/include/mach/irqs.h
index b279b82..8a147ab 100644
--- a/arch/arm/mach-bcmring/include/mach/irqs.h
+++ b/arch/arm/mach-bcmring/include/mach/irqs.h
@@ -129,4 +129,7 @@
 #define IRQ_INTC1_VALID_MASK        0x07ffffff
 #define IRQ_SINTC_VALID_MASK        0x0000ffff
 
+#define	gpio_to_irq(gpio)	((gpio) + IRQ_GPIO_0)
+#define	irq_to_gpio(irq)	((irq) - IRQ_GPIO_0)
+
 #endif /* ARCH_BCMRING_IRQS_H */
-- 
1.6.0.6

Leo Chen
