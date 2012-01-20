From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:26:07 +0000
Subject: [PATCH 11/31] ARM: amba: lpc32xx: get rid of NO_IRQ initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAjX-0005F1-KZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/phy3250.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bfee5b4..025eb21 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -161,7 +161,7 @@ static struct amba_device lpc32xx_clcd_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_LCD, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_LCD},
 };
 
 /*
@@ -203,7 +203,7 @@ static struct amba_device lpc32xx_ssp0_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_SSP0, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_SSP0},
 };
 
 /* AT25 driver registration */
-- 
1.7.4.4
