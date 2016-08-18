From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 18 Aug 2016 15:44:31 +0900
Subject: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer
Message-ID: <20160818064431.8982-1-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new entry for the Samsung SPI driver supported by the
drivers/spi/spi-s3c* and remove it from its original place under
"ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".

The original maintainership inherited from the Samsung Exynos
ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
will help and co-maintain the driver.

CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Mark Brown <broonie@kernel.org>
CC: linux-samsung-soc at vger.kernel.org
CC: linux-spi at vger.kernel.org
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
Hi,

this patch depends on Krzysztof's previous patch-set on the
MAINTAINER file: https://lkml.org/lkml/2016/8/16/571

Thanks,
Andi

 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9cd8d3..c305fa2 100644
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
@@ -10240,6 +10239,15 @@ S:	Supported
 L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
 F:	drivers/clk/samsung/
 
+SAMSUNG SPI DRIVERS
+M:	Kukjin Kim <kgene@kernel.org>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Andi Shyti <andi.shyti@samsung.com>
+L:	linux-spi at vger.kernel.org
+L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/spi/spi-s3c*
+
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
 M:	Girish K S <ks.giri@samsung.com>
-- 
2.8.1
