From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Nov 2018 16:05:52 +0000 (GMT)
Subject: Applied "spi: mediatek: add spi support for mt7629 IC" to the spi tree
In-Reply-To: <1542703268-17285-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20181128160552.7DDA5112521B@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: add spi support for mt7629 IC

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 942779c6f1f899bc54332f7bb67666244f3f6d6c Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 20 Nov 2018 16:41:08 +0800
Subject: [PATCH] spi: mediatek: add spi support for mt7629 IC

this patch add support for mt7629 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9ee1fe968a2d..0cce6f0ba824 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -150,6 +150,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt7622-spi",
 		.data = (void *)&mt7622_compat,
 	},
+	{ .compatible = "mediatek,mt7629-spi",
+		.data = (void *)&mt7622_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
2.19.0.rc2
