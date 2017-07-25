From: guochun.mao@mediatek.com (Guochun Mao)
Date: Tue, 25 Jul 2017 10:10:17 +0800
Subject: [PATCH] dt-bindings: mtd: add new compatible strings for mtk nor
 controller
In-Reply-To: <1500948617-19627-1-git-send-email-guochun.mao@mediatek.com>
References: <1500948617-19627-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1500948617-19627-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "mediatek,mt2712-nor" and "mediatek,mt7622-nor"
for nor flash node's compatible strings.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 5ded66a..9845ff4 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -3,6 +3,8 @@
 Required properties:
 - compatible: 	  The possible values are:
 		  "mediatek,mt2701-nor"
+		  "mediatek,mt2712-nor"
+		  "mediatek,mt7622-nor"
 		  "mediatek,mt7623-nor"
 		  "mediatek,mt8173-nor"
 		  For mt8173, compatible should be "mediatek,mt8173-nor".
-- 
1.7.9.5
