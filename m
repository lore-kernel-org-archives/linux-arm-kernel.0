From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 27 May 2013 20:07:25 +0530
Subject: [PATCH v2 13/14] Documentation: dt: binding: serial: omap: am43x
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Message-ID: <c25bea2491ad5137ece8d924e5c20e46f6e2886b.1369658705.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM43x uart binding.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 342eedd..f37fdda 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
+- compatible : "ti,am4372-uart","ti,omap2-uart" for AM43x controller
 - ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
 
 Optional properties:
-- 
1.7.12
