From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 May 2016 18:27:33 +0100
Subject: Applied "spi: dw-pci: Spelling s/paltforms/platforms/g" to the spi
 tree
In-Reply-To: <1462906798-27993-3-git-send-email-geert+renesas@glider.be>
Message-ID: <E1b0Xv3-0000TA-HX@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: dw-pci: Spelling s/paltforms/platforms/g

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

>From 3208a1ccb23018c650ff9e08c4bd1c8b01f6d8f1 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 May 2016 20:59:58 +0200
Subject: [PATCH] spi: dw-pci: Spelling s/paltforms/platforms/g

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 332ccb0539a7..ef7db75c92c1 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -67,7 +67,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dws->irq = pdev->irq;
 
 	/*
-	 * Specific handling for paltforms, like dma setup,
+	 * Specific handling for platforms, like dma setup,
 	 * clock rate, FIFO depth.
 	 */
 	if (desc) {
-- 
2.8.1
