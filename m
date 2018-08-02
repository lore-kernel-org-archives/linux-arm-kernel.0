From: broonie@kernel.org (Mark Brown)
Date: Thu,  2 Aug 2018 11:12:24 +0100 (BST)
Subject: Applied "spi: uniphier: remove unnecessary include headers" to the
 spi tree
In-Reply-To: <1533184963-28508-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20180802101224.A50D71124241@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: uniphier: remove unnecessary include headers

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

>From 07ebbbe458790d3c75f4a2f3634d8e04f66b389b Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Thu, 2 Aug 2018 13:42:43 +0900
Subject: [PATCH] spi: uniphier: remove unnecessary include headers

This commit removed include headers of linux/of.h and linux/of_platform.h,
because they are not used.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 089985465890..5a6137fe172d 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
-- 
2.18.0
