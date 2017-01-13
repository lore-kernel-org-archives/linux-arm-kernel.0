From: guochun.mao@mediatek.com (Guochun Mao)
Date: Fri, 13 Jan 2017 15:13:28 +0800
Subject: [PATCH v1 1/2] Documentation: mtk-quadspi: update DT bindings
In-Reply-To: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
References: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
Message-ID: <1484291609-20195-2-git-send-email-guochun.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "mediatek,mt2701-nor" for nor flash node's compatible.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index fb314f0..f83d31d 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -1,7 +1,9 @@
 * Serial NOR flash controller for MTK MT81xx (and similar)
 
 Required properties:
-- compatible: 	  should be "mediatek,mt8173-nor";
+- compatible: 	  should contain:
+		  "mediatek,mt2701-nor" for MT2701,
+		  "mediatek,mt8173-nor" for MT8173.
 - reg: 		  physical base address and length of the controller's register
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
-- 
1.7.9.5
