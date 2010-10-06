From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed,  6 Oct 2010 08:50:42 +0300
Subject: [PATCHv2 3/3] OMAP: McBSP: Remove null omap44xx ops comment
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1286344242-430-4-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems these comments where accidentally added so remove them.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mcbsp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index f6b772e..f9c9df5 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -240,21 +240,18 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP2,
-		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP3_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP3,
-		/* XXX .ops ? */
 	},
 	{
 		.phys_base      = OMAP44XX_MCBSP4_BASE,
 		.dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
 		.dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
 		.tx_irq         = OMAP44XX_IRQ_MCBSP4,
-		/* XXX .ops ? */
 	},
 };
 #define OMAP44XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap44xx_mcbsp_pdata)
-- 
1.7.1
