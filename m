From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  8 Sep 2010 11:25:39 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Prototype SPI devices
In-Reply-To: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1283941539-3892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoids build warnings due to the undeclared non-statics.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
index bfa3ef7..405e621 100644
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -22,6 +22,7 @@
 
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
+#include <plat/devs.h>
 
 static char *spi_src_clks[] = {
 	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
-- 
1.7.1
