From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 May 2017 11:40:21 +0200
Subject: [PATCH 4/4] dt-bindings: i2c-mtk: Add mt7623 binding
In-Reply-To: <20170522094021.7837-1-matthias.bgg@gmail.com>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
Message-ID: <20170522094021.7837-4-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mt7623 dtsi has support for the i2c block, but this is not documented.
Add the documentation for SoC mt7623 to de description.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index 060a9ec98215..aa36099dcee7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -6,6 +6,7 @@ Required properties:
   - compatible: value should be either of the following.
       "mediatek,mt6577-i2c": for i2c compatible with mt6577.
       "mediatek,mt6589-i2c": for i2c compatible with mt6589.
+      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
       "mediatek,mt8173-i2c": for i2c compatible with mt8173.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
-- 
2.12.0
