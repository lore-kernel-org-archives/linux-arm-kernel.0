From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:08:49 -0600
Subject: [RFT/RFC/PATCH 02/31] arm: omap: irq: define INTC_ILR0 register
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is currently used as a hardcoded 0x100
offset.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 748f86b..c9539b1 100644
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
1.8.4.GIT
