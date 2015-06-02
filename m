From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 19:32:28 +0200
Subject: [PATCH 4/7] Documentation: bindings: add the Berlin nand controller
 compatible
In-Reply-To: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1433266351-22587-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin nand controller support was introduced using the existing
pxa3xx nand driver. Add the Berlin specific compatible into the
documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
index ad30a02f1346..e0adc584fdce 100644
--- a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
@@ -5,6 +5,7 @@ Required properties:
  - compatible:		Should be set to one of the following:
 			marvell,pxa3xx-nand
 			marvell,armada370-nand
+			marvell,berlin2-nand
  - reg: 		The register base for the controller
  - interrupts:		The interrupt to map
  - #address-cells:	Set to <1> if the node includes partitions
-- 
2.4.2
