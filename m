From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 8 Jun 2015 10:33:16 +0200
Subject: [PATCH v2 3/3] dmaengine: at_xdmac: fix indentation
In-Reply-To: <1433752399-26231-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433751820-26142-1-git-send-email-ludovic.desroches@atmel.com>
 <1433752399-26231-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1433752399-26231-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix indentation.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/dma/at_xdmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index e5dd730..7614c5c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -624,12 +624,12 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		       unsigned int sg_len, enum dma_transfer_direction direction,
 		       unsigned long flags, void *context)
 {
-	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
-	struct at_xdmac_desc	*first = NULL, *prev = NULL;
-	struct scatterlist	*sg;
-	int			i;
-	unsigned int		xfer_size = 0;
-	unsigned long		irqflags;
+	struct at_xdmac_chan		*atchan = to_at_xdmac_chan(chan);
+	struct at_xdmac_desc		*first = NULL, *prev = NULL;
+	struct scatterlist		*sg;
+	int				i;
+	unsigned int			xfer_size = 0;
+	unsigned long			irqflags;
 	struct dma_async_tx_descriptor	*ret = NULL;
 
 	if (!sgl)
-- 
2.2.0
