From: nm@ti.com (Nishanth Menon)
Date: Mon, 22 Feb 2016 10:51:08 -0600
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Enable AT24 eeprom
In-Reply-To: <1456159868-32416-1-git-send-email-nm@ti.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
Message-ID: <1456159868-32416-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT24 compatible eeproms are used in BB family and X15 boards.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d18d6b42fcf5..fa82f4e25d0e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -145,6 +145,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_TSL2550=m
 CONFIG_BMP085_I2C=m
 CONFIG_SRAM=y
+CONFIG_EEPROM_AT24=m
 CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
-- 
2.7.0
