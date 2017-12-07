From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 7 Dec 2017 14:43:22 +0800
Subject: [PATCH v2 1/3] mmc: dt-bindings: add mmc support to MT7623 SoC
In-Reply-To: <cover.1512628593.git.sean.wang@mediatek.com>
References: <cover.1512628593.git.sean.wang@mediatek.com>
Message-ID: <4f06b509e1e3d4cf5578841cfcf7ec966afd2d48.1512628593.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add the devicetree binding for MT7623 SoC using MT2701 as the fallback.

Cc: devicetree at vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 72d2a73..9b80176 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -12,6 +12,8 @@ Required properties:
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
+	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
+
 - reg: physical base address of the controller and length
 - interrupts: Should contain MSDC interrupt number
 - clocks: Should contain phandle for the clock feeding the MMC controller
-- 
2.7.4
