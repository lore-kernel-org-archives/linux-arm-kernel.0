From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Dec 2014 14:24:37 +0100
Subject: [PATCH 1/4] ARM: at91/defconfig: add the XDMA driver
Message-ID: <eb931e7c5534cd949ba61307f0380826e62ceb2c.1417440150.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Atmel eXtended DMA Controller driver option. This driver is first used
on SAMA5D4 SoCs and only relevant in sama5_defconfig file.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 12e1fcbc9a2b..d1a2ee5b7b50 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -177,6 +177,7 @@ CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_DMADEVICES=y
+CONFIG_AT_XDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.1.3
