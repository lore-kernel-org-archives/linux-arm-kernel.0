From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 31 Aug 2018 16:41:39 +0300
Subject: [RESEND PATCH v11 4/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
Message-ID: <20180831134141.9335-5-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94b37382cd2b..d58bc2d6bb3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9542,6 +9542,13 @@ F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <pirea.radu@gmail.com>
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
