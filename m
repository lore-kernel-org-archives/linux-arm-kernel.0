From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:08:53 -0600
Subject: [RFT/RFC/PATCH 06/31] arm: omap: irq: remove unused macro
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index cfca775..0772a3db 100644
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
1.8.4.GIT
