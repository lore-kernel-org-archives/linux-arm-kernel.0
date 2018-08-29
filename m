From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:45 +0200
Subject: [PATCH 09/11] MAINTAINERS: remove the / ATMEL string from MICROCHIP
 entries
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <9952380c6c76d898c9cf72979efbe6b50360660f.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to keep this additional string as it can puzzle people
while adding new driver's entries.
Move the NAND entry to keep it alphabetically ordered.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f5494b33d89..4e9b9a52bc6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9501,13 +9501,13 @@ T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 S:	Supported
 F:	arch/microblaze/
 
-MICROCHIP / ATMEL AT91 SERIAL DRIVER
+MICROCHIP AT91 SERIAL DRIVER
 M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
 
-MICROCHIP / ATMEL DMA DRIVER
+MICROCHIP DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine at vger.kernel.org
@@ -9518,13 +9518,13 @@ F:	include/linux/platform_data/dma-atmel.h
 F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
 F:	include/dt-bindings/dma/at91.h
 
-MICROCHIP / ATMEL ECC DRIVER
+MICROCHIP ECC DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-crypto at vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
-MICROCHIP / ATMEL ISC DRIVER
+MICROCHIP ISC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media at vger.kernel.org
 S:	Supported
@@ -9532,13 +9532,6 @@ F:	drivers/media/platform/atmel/atmel-isc.c
 F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
-MICROCHIP / ATMEL NAND DRIVER
-M:	Tudor Ambarus <tudor.ambarus@microchip.com>
-L:	linux-mtd at lists.infradead.org
-S:	Supported
-F:	drivers/mtd/nand/raw/atmel/*
-F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
-
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -9556,6 +9549,13 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP NAND DRIVER
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
+L:	linux-mtd at lists.infradead.org
+S:	Supported
+F:	drivers/mtd/nand/raw/atmel/*
+F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
+
 MICROCHIP PWM DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1
