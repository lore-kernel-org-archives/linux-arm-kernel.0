From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 21 Mar 2013 15:45:42 +0100
Subject: [PATCH] DMA: of: const name fixup
In-Reply-To: <20130321125459.GU10326@intel.com>
References: <20130321125459.GU10326@intel.com>
Message-ID: <1363877142-14662-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Sorry, this one was actually missing in the first patch I sent.

Regards,

Markus

 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 274071c..f30b096 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1007,7 +1007,7 @@ struct dma_chan *net_dma_find_channel(void);
 static inline struct dma_chan
 *__dma_request_slave_channel_compat(dma_cap_mask_t *mask, dma_filter_fn fn,
 				  void *fn_param, struct device *dev,
-				  char *name)
+				  const char *name)
 {
 	struct dma_chan *chan;
 
-- 
1.8.1.5
