From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 2 Jan 2013 15:57:27 +0530
Subject: [PATCH v3 3/7] ARM: OMAP2+: omap2plus_defconfig: Add tsl2550 support
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Message-ID: <1357122451-7577-4-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x-evm device have tsl2550 ambient light sensor, one has to
manually enable this support to use light sensor. So this patch
enables tsl2550 driver as module in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8fd208a..cd1cd51 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -84,6 +84,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_LIS3LV02D=m
+CONFIG_SENSORS_TSL2550=m
 CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.7.9.5
