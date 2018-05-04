From: radu.pirea@microchip.com (Radu Pirea)
Date: Fri, 4 May 2018 18:47:11 +0300
Subject: [PATCH v2 3/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
Message-ID: <20180504154714.5109-4-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca06c6f58299..9243b9007966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9199,6 +9199,13 @@ S:	Supported
 F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 
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
