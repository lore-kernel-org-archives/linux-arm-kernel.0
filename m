From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 21 Nov 2012 12:29:18 +0530
Subject: [PATCH 2/7] ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d
 accelerometer
In-Reply-To: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Message-ID: <1353481163-29462-3-git-send-email-anilkumar@ti.com>
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
index 2cf6d0e..c69c08d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -83,6 +83,8 @@ CONFIG_MTD_UBI=y
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
