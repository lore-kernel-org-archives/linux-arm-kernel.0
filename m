From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Apr 2017 23:25:31 +0200
Subject: [PATCH 2/2] dmaengine: s3c24xx: Fix a typo in a comment line
In-Reply-To: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
References: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
Message-ID: <9455dbb2-0c61-6b2c-72d5-e555f78433b9@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 22 Apr 2017 23:09:03 +0200

Add a missing character in this description for a data structure member.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/s3c24xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 967229829683..da79b2c6989f 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -159,7 +159,7 @@ struct s3c24xx_sg {
  * struct s3c24xx_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
  * @dsg_list: list of children sg's
- * @at: sg currently being transfered
+ * @at: sg currently being transferred
  * @width: transfer width
  * @disrcc: value for source control register
  * @didstc: value for destination control register
-- 
2.12.2
