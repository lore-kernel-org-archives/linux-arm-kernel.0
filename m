From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:15:54 -0500
Subject: [PATCH 06/35] arm: omap: irq: remove unused macro
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8c85c39..8905ebb 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -42,8 +42,6 @@
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
 #define INTC_ILR0		0x0100
-/* Number of IRQ state bits in each MIR register */
-#define IRQ_BITS_PER_REG	32
 
 #define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-- 
2.0.1.563.g66f467c
