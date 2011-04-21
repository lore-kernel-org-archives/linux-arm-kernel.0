From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 21 Apr 2011 11:22:31 +0200
Subject: [PATCH] MXS DMA: add end of list sentinel to platform_id list
Message-ID: <9888fc5695f320d8b5e9a9014fe0c1a0eab24bb5.1303373126.git.LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa??mann <LW@KARO-electronics.de>
---
 drivers/dma/mxs-dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index e25209b..5b9b66a 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -737,7 +737,8 @@ static struct platform_device_id mxs_dma_type[] = {
 	}, {
 		.name = "mxs-dma-apbx",
 		.driver_data = MXS_DMA_APBX,
-	}
+	},
+	{ /* end of list marker */ }
 };
 
 static struct platform_driver mxs_dma_driver = {
-- 
1.5.6.5
