From: colin.king@canonical.com (Colin King)
Date: Mon, 26 Jun 2017 14:39:12 +0100
Subject: [PATCH] spi: sirf: fix spelling mistake: "registerred" -> "registered"
Message-ID: <20170626133912.23808-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_info message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 7072276ad354..bbb1a275f718 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1158,7 +1158,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
 		goto free_clk;
-	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
+	dev_info(&pdev->dev, "registered, bus number = %d\n", master->bus_num);
 
 	return 0;
 free_clk:
-- 
2.11.0
