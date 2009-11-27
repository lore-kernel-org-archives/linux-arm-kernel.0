From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Nov 2009 16:43:54 +0000
Subject: [PATCH 2/7] S3C6410: Correct names of IISv4 data output pin
	definitions
In-Reply-To: <20091127164312.GA11913@rakim.wolfsonmicro.main>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
Message-ID: <1259340239-12067-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The naming of the defines suggests that there are three IISv4 ports
with one data line each when in fact there is a single IISv4 port
with three data lines.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h b/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
index c47daf7..e22b49f 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
+++ b/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
@@ -36,18 +36,18 @@
 
 #define S3C64XX_GPC4_SPI_MISO1		(0x02 << 16)
 #define S3C64XX_GPC4_MMC2_CMD		(0x03 << 16)
-#define S3C64XX_GPC4_I2S0_V40_DO	(0x05 << 16)
+#define S3C64XX_GPC4_I2S_V40_DO0	(0x05 << 16)
 #define S3C64XX_GPC4_EINT_G2_4		(0x07 << 16)
 
 #define S3C64XX_GPC5_SPI_CLK1		(0x02 << 20)
 #define S3C64XX_GPC5_MMC2_CLK		(0x03 << 20)
-#define S3C64XX_GPC5_I2S1_V40_DO	(0x05 << 20)
+#define S3C64XX_GPC5_I2S_V40_DO1	(0x05 << 20)
 #define S3C64XX_GPC5_EINT_G2_5		(0x07 << 20)
 
 #define S3C64XX_GPC6_SPI_MOSI1		(0x02 << 24)
 #define S3C64XX_GPC6_EINT_G2_6		(0x07 << 24)
 
 #define S3C64XX_GPC7_SPI_nCS1		(0x02 << 28)
-#define S3C64XX_GPC7_I2S2_V40_DO	(0x05 << 28)
+#define S3C64XX_GPC7_I2S_V40_DO2	(0x05 << 28)
 #define S3C64XX_GPC7_EINT_G2_7		(0x07 << 28)
 
-- 
1.6.5.3
