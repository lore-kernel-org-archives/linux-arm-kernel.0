From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Mon, 4 Jan 2016 14:15:37 +0800
Subject: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek MT2701 soc
Message-ID: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dt binding for the MT2701 soc.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
index 0ce6fa3..ef22ecf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
-      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
-      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
-      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
-      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
+	"mediatek,mt2701-i2c", for i2c compatible with mt2701 i2c.
+	"mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
+	"mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
+	"mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
+	"mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
+	"mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
1.8.1.1.dirty
