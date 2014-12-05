From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri,  5 Dec 2014 19:07:49 +0530
Subject: [PATCH] dma: pl330: update author info
Message-ID: <1417786669-5124-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update email-id to a personal one, as I have changed employment.

Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8ec5f1f..69ad8417 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2803,6 +2803,6 @@ static struct amba_driver pl330_driver = {
 
 module_amba_driver(pl330_driver);
 
-MODULE_AUTHOR("Jaswinder Singh <jassi.brar@samsung.com>");
+MODULE_AUTHOR("Jaswinder Singh <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("API Driver for PL330 DMAC");
 MODULE_LICENSE("GPL");
-- 
1.9.1
