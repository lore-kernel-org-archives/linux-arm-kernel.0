From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Jan 2017 17:42:08 +0100
Subject: [PATCH] MAINTAINERS: dmaengine: Update + Hand over the at_hdmac
 driver to Ludovic
Message-ID: <20170102164208.6038-1-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hand over the Microchip / Atmel DMA driver handled by at_hdmac driver
to Ludovic who is responsible for the newer at_xdmac driver as well.
Also update the entry name and position to follow company changes.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

FYI: I based my patch on latest linux-next: next-20161224.
Tell me if it's easier for you to base it on another tree.

Regards,

 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdd9d5e37ff1..cb3b8624cd1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2194,14 +2194,6 @@ L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
 
-ATMEL DMA DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/dma/at_hdmac.c
-F:	drivers/dma/at_hdmac_regs.h
-F:	include/linux/platform_data/dma-atmel.h
-
 ATMEL XDMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@atmel.com>
 L:	linux-arm-kernel at lists.infradead.org
@@ -8191,6 +8183,15 @@ S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	include/linux/atmel_serial.h
 
+MICROCHIP / ATMEL DMA DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	dmaengine at vger.kernel.org
+S:	Supported
+F:	drivers/dma/at_hdmac.c
+F:	drivers/dma/at_hdmac_regs.h
+F:	include/linux/platform_data/dma-atmel.h
+
 MICROCHIP / ATMEL ISC DRIVER
 M:	Songjun Wu <songjun.wu@microchip.com>
 L:	linux-media at vger.kernel.org
-- 
2.9.0
