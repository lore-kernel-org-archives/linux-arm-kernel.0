From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 13 Jun 2016 22:37:06 +0200
Subject: [PATCH 3/3] sunxi: Add "allwinner,
 sun6i-a31-mmc" support in the driver.
In-Reply-To: <1465850226-37420-1-git-send-email-manu@freebsd.org>
References: <1465850226-37420-1-git-send-email-manu@freebsd.org>
Message-ID: <1465850226-37420-4-git-send-email-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 drivers/mmc/host/sunxi-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2ee4c21..333db71 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -941,6 +941,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", },
 	{ .compatible = "allwinner,sun5i-a13-mmc", },
+	{ .compatible = "allwinner,sun6i-a31-mmc", },
 	{ .compatible = "allwinner,sun9i-a80-mmc", },
 	{ /* sentinel */ }
 };
-- 
2.8.1
