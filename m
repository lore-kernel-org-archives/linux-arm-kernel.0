From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon,  2 Sep 2013 13:44:58 +0530
Subject: [PATCH 1/2] dma: ste_dma40: Remove duplicate const
Message-ID: <1378109699-25245-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'const' was added twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/dma/ste_dma40.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 7bbcabb..df0a606 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3485,7 +3485,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 {
 	struct stedma40_platform_data *pdata;
 	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
-	const const __be32 *list;
+	const __be32 *list;
 
 	pdata = devm_kzalloc(&pdev->dev,
 			     sizeof(struct stedma40_platform_data),
-- 
1.7.9.5
