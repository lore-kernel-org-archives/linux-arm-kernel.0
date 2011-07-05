From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  5 Jul 2011 14:21:46 -0600
Subject: [PATCH] i2c: tegra: Use engineering names in DT compatible property
Message-ID: <1309897306-22953-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Engineering names are more stable than marketing names. Hence, use them
for Device Tree compatible properties instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Grant, this is against devicetree/arm and also makes sense for
devicetree/test.

 drivers/i2c/busses/i2c-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 8914bd1..99b1b6d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -716,7 +716,7 @@ static int tegra_i2c_resume(struct platform_device *pdev)
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
 static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
-	{ .compatible = "nvidia,tegra250-i2c", },
+	{ .compatible = "nvidia,tegra20-i2c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
-- 
1.7.0.4
