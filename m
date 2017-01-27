From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 27 Jan 2017 17:28:40 +0100
Subject: [PATCH 1/3] MAINTAINERS: at91: change email address
Message-ID: <20170127162842.706-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Following the Microchip / Atmel merger and the unification of internal IT, it's
more convenient for me to swith to the microchip.com address. Change all my
entries to reflect this.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9e3d94..d0f5de961ff5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1091,7 +1091,7 @@ F:	arch/arm/boot/dts/aspeed-*
 F:	drivers/*/*aspeed*
 
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
 M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -2178,7 +2178,7 @@ S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
 ATMEL AT91 SAMA5D2-Compatible Shutdown Controller
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
@@ -2189,7 +2189,7 @@ S:	Supported
 F:	drivers/iio/adc/at91-sama5d2_adc.c
 
 ATMEL Audio ALSA driver
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
@@ -2223,14 +2223,14 @@ F:	drivers/media/platform/soc_camera/atmel-isi.c
 F:	include/media/atmel-isi.h
 
 ATMEL LCDFB DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev at vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/atmel_lcdfb.c
 F:	include/video/atmel_lcdc.h
 
 ATMEL MACB ETHERNET DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/net/ethernet/cadence/
 
@@ -2248,26 +2248,26 @@ S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
 
 ATMEL SPI DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
 ATMEL SSC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
 
 ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel_tclib.c
 F:	drivers/clocksource/tcb_clksrc.c
 
 ATMEL USBA UDC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/usb/gadget/udc/atmel_usba_udc.*
-- 
2.11.0
