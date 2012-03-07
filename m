From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed,  7 Mar 2012 15:33:34 +0100
Subject: [PATCH v2 02/13] dmaengine: imx-dma: remove data member from internal
 structure.
In-Reply-To: <1331130825-14947-1-git-send-email-javier.martin@vista-silicon.com>
References: <1331130825-14947-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1331130825-14947-3-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Internal structure is just an auxiliary structure used for the initial
merge which is meant to be gone. As data member is not use anywhere
we can simply remove it.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 drivers/dma/imx-dma.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 28d716c..1a9be6d 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -132,7 +132,6 @@ enum  imxdma_prep_type {
  */
 
 struct imxdma_channel_internal {
-	void *data;
 	unsigned int dma_mode;
 	struct scatterlist *sg;
 	unsigned int resbytes;
-- 
1.7.0.4
