From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 13 Jul 2018 19:47:34 +0300
Subject: [PATCH v11 4/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180713164736.26028-1-radu.pirea@microchip.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
Message-ID: <20180713164736.26028-5-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ac6e6af5292..f849cc4acbf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9362,6 +9362,13 @@ F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-spi at vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.18.0
