From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:24:59 +0100
Subject: Applied "spi: sirf: fix spelling mistake: "registerred" ->
 "registered"" to the spi tree
In-Reply-To: <20170626133912.23808-1-colin.king@canonical.com>
Message-ID: <E1dQIaB-0004ZE-0m@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: sirf: fix spelling mistake: "registerred" -> "registered"

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

>From 2d781e89e2b2f2195a8ef06fdc5325e46f26c8eb Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 26 Jun 2017 14:39:12 +0100
Subject: [PATCH] spi: sirf: fix spelling mistake: "registerred" ->
 "registered"

Trivial fix to spelling mistake in dev_info message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
