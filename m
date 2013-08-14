From: zonque@gmail.com (Daniel Mack)
Date: Wed, 14 Aug 2013 18:35:03 +0200
Subject: [PATCH] dma: dmagengine: fix function names in comments
Message-ID: <1376498103-23742-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix for function name mismatches I stumbled over.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 5932ab1..0947ff6 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -504,7 +504,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 }
 
 /**
- * dma_request_channel - try to get specific channel exclusively
+ * dma_request_slave_channel - try to get specific channel exclusively
  * @chan: target channel
  */
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
@@ -530,7 +530,7 @@ struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
 EXPORT_SYMBOL_GPL(dma_get_slave_channel);
 
 /**
- * dma_request_channel - try to allocate an exclusive channel
+ * __dma_request_channel - try to allocate an exclusive channel
  * @mask: capabilities that the channel must satisfy
  * @fn: optional callback to disposition available channels
  * @fn_param: opaque parameter to pass to dma_filter_fn
-- 
1.8.3.1
