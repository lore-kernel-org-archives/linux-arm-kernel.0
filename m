From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Mon, 18 Feb 2013 15:20:52 +0200
Subject: [PATCH] ARM: OMAP2+: omap2plus_defconfig: Add support for BMP085
 pressure sensor
Message-ID: <1361193652-25313-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables BMP085 pressure sensor that can be
found on OMAP4 Blaze Tablet development platform

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b16bae2..6a4e9a2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -93,6 +93,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_LIS3LV02D=m
 CONFIG_SENSORS_TSL2550=m
 CONFIG_SENSORS_LIS3_I2C=m
+CONFIG_BMP085_I2C=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.7.9.5
