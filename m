From: radu.pirea@microchip.com (Radu Pirea)
Date: Mon, 4 Jun 2018 19:59:41 +0300
Subject: [PATCH v5 4/6] MAINTAINERS: add at91 usart spi driver
In-Reply-To: <20180604165943.31381-1-radu.pirea@microchip.com>
References: <20180604165943.31381-1-radu.pirea@microchip.com>
Message-ID: <20180604165943.31381-5-radu.pirea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12203d07c6af..dae31df711fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9201,6 +9201,13 @@ F:	drivers/mfd/at91-usart.c
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
2.17.1
