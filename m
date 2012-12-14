From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 14 Dec 2012 11:03:00 +0530
Subject: [PATCH v2 4/8] ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550
 ambient light sensor
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Message-ID: <1355463184-16283-5-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x-evm device have tsl2550 ambient light sensor, one has to
manually enable this support to use light sensor. So this patch
enables tsl2550 driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 417a320..f0d6afb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -82,6 +82,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_LIS3LV02D=y
+CONFIG_SENSORS_TSL2550=y
 CONFIG_SENSORS_LIS3_I2C=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.7.9.5
