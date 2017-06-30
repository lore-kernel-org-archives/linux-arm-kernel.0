From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 30 Jun 2017 14:03:04 +0800
Subject: [PATCH v1 1/4] dt-bindings: media: mtk-cir: Add support for MT7622 SoC
In-Reply-To: <cover.1498794408.git.sean.wang@mediatek.com>
References: <cover.1498794408.git.sean.wang@mediatek.com>
Message-ID: <a778a3a33a273f00d3ff071d62fe672a207d949c.1498794408.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Document the devicetree bindings for CIR on MediaTek MT7622
SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/media/mtk-cir.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mtk-cir.txt b/Documentation/devicetree/bindings/media/mtk-cir.txt
index 2be2005..5e18087 100644
--- a/Documentation/devicetree/bindings/media/mtk-cir.txt
+++ b/Documentation/devicetree/bindings/media/mtk-cir.txt
@@ -2,10 +2,14 @@ Device-Tree bindings for Mediatek consumer IR controller
 found in Mediatek SoC family
 
 Required properties:
-- compatible	    : "mediatek,mt7623-cir"
+- compatible	    : Should be
+			"mediatek,mt7623-cir": for MT7623 SoC
+			"mediatek,mt7622-cir": for MT7622 SoC
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
-- clock-names	    : should contain "clk" entries;
+- clock-names	    : should contain
+			- "clk" entries: for MT7623 SoC
+			- "clk", "bus" entries: for MT7622 SoC
 - interrupts	    : should contain IR IRQ number;
 - reg		    : should contain IO map address for IR.
 
-- 
2.7.4
