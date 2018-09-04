From: radu_nicolae.pirea@upb.ro (Radu Pirea)
Date: Tue,  4 Sep 2018 14:13:08 +0300
Subject: [PATCH v12 4/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Message-ID: <20180904111310.4049-5-radu_nicolae.pirea@upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radu Pirea <radu.pirea@microchip.com>

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aeaa2cc3e14..1bb477aab33b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9363,6 +9363,13 @@ F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
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
