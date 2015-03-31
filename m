From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 31 Mar 2015 22:14:01 +0300
Subject: [PATCHv6 08/34] Documentation: DT: document PRCM compatible strings
 for dm81x SoCs
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Message-ID: <1427829267-32077-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These PRCM nodes were earlier added in patch 7800064ba5 ("ARM: dts: Add
basic dm816x device tree configuration"), but the documentation for
the same wasn't added. Fix this by adding the missing compatible strings
under the generic prcm.txt document.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/prcm.txt          |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 79074da..68f96f8 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -29,6 +29,10 @@ Required properties:
 		"ti,dra7-prm"
 		"ti,dra7-cm-core-aon"
 		"ti,dra7-cm-core"
+		"ti,dm814-prcm"
+		"ti,dm814-scrm"
+		"ti,dm816-prcm"
+		"ti,dm816-scrm"
 - reg:		Contains PRCM module register address range
 		(base address and length)
 - clocks:	clocks for this module
-- 
1.7.9.5
