From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 29 Aug 2018 16:31:43 +0200
Subject: [PATCH 07/11] MAINTAINERS: pwm: add entry for Microchip pwm driver
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
Message-ID: <2225e38823eb3523eac02768d16bada526b48650.1535552609.git.nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the entry that was missing for pwm-atmel.c driver. Add binding file
as well.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 414324563009..fca67dcb84e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9553,6 +9553,14 @@ L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP PWM DRIVER
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-pwm at vger.kernel.org
+S:	Supported
+F:	drivers/pwm/pwm-atmel.c
+F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb at vger.kernel.org
-- 
2.17.1
