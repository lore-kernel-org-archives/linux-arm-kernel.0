From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:15:50 -0500
Subject: [PATCH 02/35] arm: omap: irq: define INTC_ILR0 register
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is currently used as a hardcoded 0x100
offset.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 7b2cf9a..96073a2 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -41,6 +41,7 @@
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
+#define INTC_ILR0		0x0100
 /* Number of IRQ state bits in each MIR register */
 #define IRQ_BITS_PER_REG	32
 
-- 
2.0.1.563.g66f467c
