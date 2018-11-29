From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 29 Nov 2018 14:29:53 +0800
Subject: [RESEND PATCH 1/4] dt-bindings: mtd: mtk-quadspi: update bindings for
 MT7629 SoC
Message-ID: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates bindings for the MT7629 SPI-NOR controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 56d3668..a12e3b5 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MTK MT81xx (and similar)
+* Serial NOR flash controller for MediaTek SoCs
 
 Required properties:
 - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
@@ -10,6 +10,7 @@ Required properties:
 		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
+		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
 - reg: 		  physical base address and length of the controller's register
 - clocks: 	  the phandle of the clocks needed by the nor controller
-- 
1.9.1
