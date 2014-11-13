From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 15:14:55 +0100
Subject: [PATCH 1/2] dmaengine: at_xdmac: correct destination abbreviation
In-Reply-To: <1415888096-22090-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415888096-22090-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415888096-22090-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TODO

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b60d77a..ff67466 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1229,7 +1229,7 @@ static int at_xdmac_device_slave_caps(struct dma_chan *dchan,
 {
 
 	caps->src_addr_widths = AT_XDMAC_DMA_BUSWIDTHS;
-	caps->dstn_addr_widths = AT_XDMAC_DMA_BUSWIDTHS;
+	caps->dst_addr_widths = AT_XDMAC_DMA_BUSWIDTHS;
 	caps->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	caps->cmd_pause = true;
 	caps->cmd_terminate = true;
-- 
2.0.3
