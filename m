From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Fri, 22 Dec 2017 17:07:08 +0200
Subject: [PATCH 01/14] MAINTAINERS: add sama5d2 resistive touchscreen
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1513955241-10985-2-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAINTAINERS entry for sama5d2 resistive touchscreen driver

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 650aa0e..8beec28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8957,6 +8957,12 @@ F:	drivers/media/platform/atmel/atmel-isc.c
 F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
+MICROCHIP / ATMEL SAMA5D2 RESISTIVE TOUCHSCREEN DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-input at vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/sama5d2_rts.c
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.7.4
