From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri,  5 Aug 2016 14:12:28 +0000
Subject: [PATCH v2 2/3] ARM: davinci_all_defconfig: enable RTC driver as module
In-Reply-To: <20160805141229.20784-1-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805141229.20784-1-kbeldan@baylibre.com>
Message-ID: <20160805141229.20784-3-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver handles the RTC of most davinci SoCs.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index f33d042..cc3e702 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -188,6 +188,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_EXT2_FS=y
-- 
2.9.0.rc1
