From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Sat, 13 Oct 2018 15:20:45 +0800
Subject: [PATCH 1/6] mmc: dt-bindings: add support for MT8183 SoC
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1539415250-32337-2-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree binding for MT8183 SoC

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f2208f4..f5bcda3 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -10,6 +10,7 @@ Required properties:
 - compatible: value should be either of the following.
 	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
+	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
-- 
1.8.1.1.dirty
