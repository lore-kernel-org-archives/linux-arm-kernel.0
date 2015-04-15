From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 15 Apr 2015 19:24:05 +0200
Subject: [PATCH v4 07/10] Documentation: bindings: add the Berlin nand
 controller compatible
In-Reply-To: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1429118648-19416-8-git-send-email-antoine.tenart@free-electrons.com>
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
index ecd1fc071f81..f33ee0aa0a2e 100644
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
2.3.5
