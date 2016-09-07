From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:40 +0200
Subject: [PATCH 4/7] spi: meson: Add GXBB compatible
In-Reply-To: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473261223-15412-5-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 2465259..616566e 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -442,6 +442,7 @@ static const struct dev_pm_ops meson_spifc_pm_ops = {
 
 static const struct of_device_id meson_spifc_dt_match[] = {
 	{ .compatible = "amlogic,meson6-spifc", },
+	{ .compatible = "amlogic,meson-gxbb-spifc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, meson_spifc_dt_match);
-- 
2.7.4
