From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:46 +0200
Subject: [PATCH 10/11] MAINTAINERS: move former ATMEL entries to proper
 MICROCHIP location
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <f3231dd16d24c4c995cc2af7848d51a76bb49982.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Standardize the Microchip / Atmel entries with the same form and move them
so that they are all located at the same place, under the newer MICROCHIP
banner.
Only modifications to the titles of the entries are done in this patch.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 154 ++++++++++++++++++++++++++--------------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9b9a52bc6e..78044223d90f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2471,42 +2471,6 @@ F:	drivers/atm/
 F:	include/linux/atm*
 F:	include/uapi/linux/atm*
 
-ATMEL AT91 / AT32 MCI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-S:	Maintained
-F:	drivers/mmc/host/atmel-mci.c
-
-ATMEL AT91 SAMA5D2-Compatible Shutdown Controller
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-S:	Supported
-F:	drivers/power/reset/at91-sama5d2_shdwc.c
-
-ATMEL Audio ALSA driver
-M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
-L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-S:	Supported
-F:	sound/soc/atmel
-
-ATMEL I2C DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-i2c at vger.kernel.org
-S:	Supported
-F:	drivers/i2c/busses/i2c-at91.c
-
-ATMEL ISI DRIVER
-M:	Eugen Hristev <eugen.hristev@microchip.com>
-L:	linux-media at vger.kernel.org
-S:	Supported
-F:	drivers/media/platform/atmel/atmel-isi.c
-F:	include/media/atmel-isi.h
-
-ATMEL LCDFB DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-fbdev at vger.kernel.org
-S:	Maintained
-F:	drivers/video/fbdev/atmel_lcdfb.c
-F:	include/video/atmel_lcdc.h
-
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
@@ -2519,46 +2483,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
-ATMEL SAMA5D2 ADC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-M:	Eugen Hristev <eugen.hristev@microchip.com>
-L:	linux-iio at vger.kernel.org
-S:	Supported
-F:	drivers/iio/adc/at91-sama5d2_adc.c
-F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
-F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
-
 ATMEL SDMMC DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-mmc at vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
 
-ATMEL SPI DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-S:	Supported
-F:	drivers/spi/spi-atmel.*
-
-ATMEL SSC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/misc/atmel-ssc.c
-F:	include/linux/atmel-ssc.h
-
-ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/misc/atmel_tclib.c
-F:	drivers/clocksource/tcb_clksrc.c
-
-ATMEL USBA UDC DRIVER
-M:	Cristian Birsan <cristian.birsan@microchip.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/usb/gadget/udc/atmel_usba_udc.*
-
 ATMEL WIRELESS DRIVER
 M:	Simon Kelley <simon@thekelleys.org.uk>
 L:	linux-wireless at vger.kernel.org
@@ -2567,13 +2497,6 @@ W:	http://atmelwlandriver.sourceforge.net/
 S:	Maintained
 F:	drivers/net/wireless/atmel/atmel*
 
-ATMEL XDMA DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-arm-kernel at lists.infradead.org
-L:	dmaengine at vger.kernel.org
-S:	Supported
-F:	drivers/dma/at_xdmac.c
-
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will.deacon@arm.com>
 M:	Peter Zijlstra <peterz@infradead.org>
@@ -9507,6 +9430,12 @@ S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
 
+MICROCHIP AUDIO ASOC DRIVERS
+M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/atmel
+
 MICROCHIP DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -9524,6 +9453,12 @@ L:	linux-crypto at vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
+MICROCHIP I2C DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-i2c at vger.kernel.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-at91.c
+
 MICROCHIP ISC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media at vger.kernel.org
@@ -9532,6 +9467,13 @@ F:	drivers/media/platform/atmel/atmel-isc.c
 F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
+MICROCHIP ISI DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-media at vger.kernel.org
+S:	Supported
+F:	drivers/media/platform/atmel/atmel-isi.c
+F:	include/media/atmel-isi.h
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -9549,6 +9491,18 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LCDFB DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-fbdev at vger.kernel.org
+S:	Maintained
+F:	drivers/video/fbdev/atmel_lcdfb.c
+F:	include/video/atmel_lcdc.h
+
+MICROCHIP MMC/SD/SDIO MCI DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+S:	Maintained
+F:	drivers/mmc/host/atmel-mci.c
+
 MICROCHIP NAND DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd at lists.infradead.org
@@ -9564,6 +9518,45 @@ S:	Supported
 F:	drivers/pwm/pwm-atmel.c
 F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 
+MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-iio at vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/at91-sama5d2_adc.c
+F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
+
+MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+S:	Supported
+F:	drivers/power/reset/at91-sama5d2_shdwc.c
+
+MICROCHIP SPI DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+S:	Supported
+F:	drivers/spi/spi-atmel.*
+
+MICROCHIP SSC DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel-ssc.c
+F:	include/linux/atmel-ssc.h
+
+MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel_tclib.c
+F:	drivers/clocksource/tcb_clksrc.c
+
+MICROCHIP USBA UDC DRIVER
+M:	Cristian Birsan <cristian.birsan@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/usb/gadget/udc/atmel_usba_udc.*
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb at vger.kernel.org
@@ -9571,6 +9564,13 @@ S:	Maintained
 F:	drivers/usb/misc/usb251xb.c
 F:	Documentation/devicetree/bindings/usb/usb251xb.txt
 
+MICROCHIP XDMA DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org
+L:	dmaengine at vger.kernel.org
+S:	Supported
+F:	drivers/dma/at_xdmac.c
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 L:	linux-mips at linux-mips.org
-- 
2.17.1
