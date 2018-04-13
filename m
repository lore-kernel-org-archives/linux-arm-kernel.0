From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 13 Apr 2018 19:11:15 +0300
Subject: [PATCH 1/3] MAINTAINERS: add usart spi driver
In-Reply-To: <20180413161117.20274-1-radu.pirea@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
Message-ID: <20180413161117.20274-2-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for at91 usart spi driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e2a2fddbd19..8f80d0e30573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9192,6 +9192,13 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-spi at vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.0
