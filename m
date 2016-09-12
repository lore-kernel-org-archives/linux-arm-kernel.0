From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Sep 2016 20:12:28 +0100
Subject: Applied "spi: meson: Add GXBB compatible" to the spi tree
In-Reply-To: <1473261223-15412-5-git-send-email-jbrunet@baylibre.com>
Message-ID: <E1bjWea-0003hH-1K@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: meson: Add GXBB compatible

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2f58ea64bd8931bd7709732fe0a96e0bfb44a00b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Thu, 8 Sep 2016 09:53:26 +0200
Subject: [PATCH] spi: meson: Add GXBB compatible

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 2465259f6241..616566e793c6 100644
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
2.8.1
