From: guochun.mao@mediatek.com (Guochun Mao)
Date: Fri, 21 Jul 2017 10:36:35 +0800
Subject: [PATCH] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1500604595-21185-1-git-send-email-guochun.mao@mediatek.com>
References: <1500604595-21185-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1500604595-21185-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "mediatek,mt2712-nor" for nor flash node's compatible.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 5ded66a..35974eb 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible: 	  The possible values are:
 		  "mediatek,mt2701-nor"
+		  "mediatek,mt2712-nor"
 		  "mediatek,mt7623-nor"
 		  "mediatek,mt8173-nor"
 		  For mt8173, compatible should be "mediatek,mt8173-nor".
-- 
1.7.9.5
