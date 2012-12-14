From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:02:59 +0530
Subject: [PATCH v2 3/8] ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d
 accelerometer
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355463184-16283-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335X-EVM and AM335X-EVMSK devices have lis331dlh accelerometer, one
has to manually enable this support to use accelerometer. So this patch
enables lis3lv02d driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 27bf465..417a320 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -81,6 +81,8 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_SENSORS_LIS3LV02D=y
+CONFIG_SENSORS_LIS3_I2C=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.7.9.5
