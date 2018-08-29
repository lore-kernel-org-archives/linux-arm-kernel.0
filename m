From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:41 +0200
Subject: [PATCH 05/11] MAINTAINERS: USB: change maintainer for Microchip USBA
 gadget driver
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <79a0a7c99a4b60717b20a1523b73adaed972e6b6.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hand over this USB gadget driver to Cristian: atmel_usba.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 686822714e6b..fe1280b92a2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2551,7 +2551,7 @@ F:	drivers/misc/atmel_tclib.c
 F:	drivers/clocksource/tcb_clksrc.c
 
 ATMEL USBA UDC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Cristian Birsan <cristian.birsan@microchip.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/usb/gadget/udc/atmel_usba_udc.*
-- 
2.17.1
