From: guochun.mao@mediatek.com (Guochun Mao)
Date: Thu, 20 Jul 2017 16:29:12 +0800
Subject: [PATCH] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1500539352-9499-1-git-send-email-guochun.mao@mediatek.com>
References: <1500539352-9499-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1500539352-9499-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "mediatek,mt2712-nor" for nor flash node's compatible.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 5ded66a..592bb71 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: 	  The possible values are:
+		  "mediatek,mt2712-nor"
 		  "mediatek,mt2701-nor"
 		  "mediatek,mt7623-nor"
 		  "mediatek,mt8173-nor"
-- 
1.7.9.5
