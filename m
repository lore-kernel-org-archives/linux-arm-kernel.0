From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Aug 2016 11:17:48 +0100
Subject: Applied "MAINTAINERS: add myself as Samsung SPI maintainer" to the
 spi tree
In-Reply-To: <20160818072555.9208-1-andi.shyti@samsung.com>
Message-ID: <E1baKOS-0002Br-90@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   MAINTAINERS: add myself as Samsung SPI maintainer

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

>From 2e365a703ea60de617287354ae63bf677e406feb Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Thu, 18 Aug 2016 16:25:55 +0900
Subject: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer

Create a new entry for the Samsung SPI driver supported by the
drivers/spi/spi-s3c* and remove it from its original place under
"ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".

The original maintainership inherited from the Samsung Exynos
ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
will help and co-maintain the driver.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..5051c2f46d47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,7 +1633,6 @@ F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
 F:	drivers/memory/samsung/*
 F:	drivers/soc/samsung/*
-F:	drivers/spi/spi-s3c*
 F:	Documentation/arm/Samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
 F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
@@ -10237,6 +10236,17 @@ S:	Supported
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
 F:	drivers/clk/samsung/
 
+SAMSUNG SPI DRIVERS
+M:	Kukjin Kim <kgene@kernel.org>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Andi Shyti <andi.shyti@samsung.com>
+L:	linux-spi at vger.kernel.org
+L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
+F:	drivers/spi/spi-s3c*
+F:	include/linux/platform_data/spi-s3c64xx.h
+
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
 M:	Girish K S <ks.giri@samsung.com>
-- 
2.8.1
