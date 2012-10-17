From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 16:38:39 +0900
Subject: [PATCH 8/8] ARM: S3C64XX: Add handset module to probed Glenfarclas
 modules
In-Reply-To: <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20121017073813.GI14199@opensource.wolfsonmicro.com>
 <1350459519-20462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1350459519-20462-9-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 7e35523..2abe95d 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -711,6 +711,7 @@ static struct i2c_board_info i2c_devs1[] __devinitdata = {
 	  .irq = S3C_EINT(0),
 	  .platform_data = &glenfarclas_pmic_pdata },
 
+	{ I2C_BOARD_INFO("wlf-gf-module", 0x20) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x22) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x24) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x25) },
-- 
1.7.10.4
