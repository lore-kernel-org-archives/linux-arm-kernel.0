From: anilkumar@ti.com (AnilKumar Ch)
Date: Wed, 21 Nov 2012 12:29:21 +0530
Subject: [PATCH 5/7] ARM: OMAP2+: omap2plus_defconfig: Enable tmp275 sensor
In-Reply-To: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Message-ID: <1353481163-29462-6-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x-evm device have temperature sensor, one has to manually
enable this support to use of temperature sensor. So this patch
enables tmp275 driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9f9a637..133f04a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -135,6 +135,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_SENSORS_LM75=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
-- 
1.7.9.5
