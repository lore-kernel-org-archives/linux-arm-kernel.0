From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 27 Jan 2017 17:28:41 +0100
Subject: [PATCH 2/3] MAINTAINERS: change email address from atmel to microchip
In-Reply-To: <20170127162842.706-1-alexandre.belloni@free-electrons.com>
References: <20170127162842.706-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170127162842.706-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Use microchip email address instead of old atmel one.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0f5de961ff5..eb9739ec4e92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2173,7 +2173,7 @@ F:	include/linux/atm*
 F:	include/uapi/linux/atm*
 
 ATMEL AT91 / AT32 MCI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
@@ -2183,7 +2183,7 @@ S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 ATMEL SAMA5D2 ADC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-iio at vger.kernel.org
 S:	Supported
 F:	drivers/iio/adc/at91-sama5d2_adc.c
@@ -2203,20 +2203,20 @@ F:	drivers/dma/at_hdmac_regs.h
 F:	include/linux/platform_data/dma-atmel.h
 
 ATMEL XDMA DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org
 L:	dmaengine at vger.kernel.org
 S:	Supported
 F:	drivers/dma/at_xdmac.c
 
 ATMEL I2C DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-i2c at vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-at91.c
 
 ATMEL ISI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-media at vger.kernel.org
 S:	Supported
 F:	drivers/media/platform/soc_camera/atmel-isi.c
@@ -2242,7 +2242,7 @@ S:	Supported
 F:	drivers/mtd/nand/atmel_nand*
 
 ATMEL SDMMC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-mmc at vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
@@ -9710,7 +9710,7 @@ S:	Maintained
 F:	drivers/pinctrl/pinctrl-at91.*
 
 PIN CONTROLLER - ATMEL AT91 PIO4
-M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-gpio at vger.kernel.org
 S:	Supported
-- 
2.11.0
