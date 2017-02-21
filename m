From: colin.king@canonical.com (Colin King)
Date: Tue, 21 Feb 2017 18:30:45 +0000
Subject: [PATCH] dmaengine: stm32-dma: fix up error dev_err message
Message-ID: <20170221183046.27560-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake and make channel plural.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/stm32-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 49f86ca..786fc8f 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1008,7 +1008,7 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 
 	c = dma_get_slave_channel(&chan->vchan.chan);
 	if (!c) {
-		dev_err(dev, "No more channel avalaible\n");
+		dev_err(dev, "No more channels available\n");
 		return NULL;
 	}
 
-- 
2.10.2
