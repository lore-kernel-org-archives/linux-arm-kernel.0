From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:42 +0200
Subject: [PATCH 06/11] MAINTAINERS: dmaengine: add files to Microchip dma entry
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <4ea0eee147d544e781e46778d3abe35d63a9db69.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Microchip DMA (HDMA actually) entry, add the missing files for
better matching with get_maintainer.pl tool.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe1280b92a2e..414324563009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9512,6 +9512,8 @@ S:	Supported
 F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
 F:	include/linux/platform_data/dma-atmel.h
+F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
+F:	include/dt-bindings/dma/at91.h
 
 MICROCHIP / ATMEL ECC DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
-- 
2.17.1
