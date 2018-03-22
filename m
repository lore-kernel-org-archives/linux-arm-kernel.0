From: colin.king@canonical.com (Colin King)
Date: Thu, 22 Mar 2018 09:40:40 +0000
Subject: [PATCH] staging: mt7621-eth: fix spelling mistake: "devictree" ->
 "devicetree"
Message-ID: <20180322094040.12258-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 98b44629bc1d..eb3e14ae2929 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2096,7 +2096,7 @@ static int mtk_probe(struct platform_device *pdev)
 	sysclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sysclk)) {
 		dev_err(&pdev->dev,
-			"the clock is not defined in the devictree\n");
+			"the clock is not defined in the devicetree\n");
 		return -ENXIO;
 	}
 	eth->sysclk = clk_get_rate(sysclk);
-- 
2.15.1
