From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 11 Jul 2014 10:09:19 +0800
Subject: [PATCH 4/4] spi/rockchip: add compatible strings for RK3188 and RK3288
In-Reply-To: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
References: <1405044389-6800-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1405044559-7009-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Addy Ke <addy.ke@rockchip.com>

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Addy Ke <addy.ke@rockchip.com>
---
 drivers/spi/spi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a8866c9..cb8fd6f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -814,6 +814,8 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3066-spi", },
+	{ .compatible = "rockchip,rk3188-spi", },
+	{ .compatible = "rockchip,rk3288-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
1.8.3.2
