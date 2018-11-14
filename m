From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Nov 2018 22:27:06 +0000 (GMT)
Subject: Applied "spi: bcm2835: make license text and module license match" to
 the spi tree
In-Reply-To: <1540292769-5905-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20181114222706.EDCDD440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: bcm2835: make license text and module license match

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

>From 22bf6cd2ca4df283812a521d3cb534993072cd44 Mon Sep 17 00:00:00 2001
From: Stefan Wahren <stefan.wahren@i2se.com>
Date: Tue, 23 Oct 2018 13:06:08 +0200
Subject: [PATCH] spi: bcm2835: make license text and module license match

The license text is specifying GPL v2 or later but the MODULE_LICENSE
is set to GPL v2 which means GNU Public License v2 only. So choose the
license text as the correct one.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Kauer <florian.kauer@koalo.de>
Acked-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c    | 2 +-
 drivers/spi/spi-bcm2835aux.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f35cc10772f6..b0b87ff936c7 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -843,4 +843,4 @@ module_platform_driver(bcm2835_spi_driver);
 
 MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835");
 MODULE_AUTHOR("Chris Boot <bootc@bootc.net>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 3094d818cf06..671e374e1b01 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -542,4 +542,4 @@ module_platform_driver(bcm2835aux_spi_driver);
 
 MODULE_DESCRIPTION("SPI controller driver for Broadcom BCM2835 aux");
 MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.19.1
