From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 19 Jun 2016 23:00:45 +0800
Subject: [PATCH v3 1/2] mtd: nand: sunxi: update DT bindings
Message-ID: <20160619150046.44244-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the reset lines

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2 and v3:
  - Nothing.

 Documentation/devicetree/bindings/mtd/sunxi-nand.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
index 086d6f4..a328fbb 100644
--- a/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/sunxi-nand.txt
@@ -15,6 +15,8 @@ Optional children nodes:
 Children nodes represent the available nand chips.
 
 Optional properties:
+- reset : phandle + reset specifier pair
+- reset-names : must contain "ahb"
 - allwinner,rb : shall contain the native Ready/Busy ids.
  or
 - rb-gpios : shall contain the gpios used as R/B pins.
-- 
2.9.0
