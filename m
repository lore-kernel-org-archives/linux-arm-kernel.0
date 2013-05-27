From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 27 May 2013 20:07:14 +0530
Subject: [PATCH v2 12/14] Documentation: dt: binding: omap: am43x counter
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Message-ID: <755964dc45ae4f023540c05e5739fca87d0ea70b.1369658705.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM43x 32K counter binding.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/counter.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/counter.txt b/Documentation/devicetree/bindings/arm/omap/counter.txt
index 5bd8aa0..9c48dca 100644
--- a/Documentation/devicetree/bindings/arm/omap/counter.txt
+++ b/Documentation/devicetree/bindings/arm/omap/counter.txt
@@ -2,6 +2,7 @@ OMAP Counter-32K bindings
 
 Required properties:
 - compatible:	Must be "ti,omap-counter32k" for OMAP controllers
+		"ti,am4372-counter32k","ti,omap-counter32k" for AM43x counter
 - reg:		Contains timer register address range (base address and length)
 - ti,hwmods:	Name of the hwmod associated to the counter, which is typically
 		"counter_32k"
-- 
1.7.12
