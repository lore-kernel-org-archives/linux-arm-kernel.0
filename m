From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 21 Aug 2017 11:36:53 +0800
Subject: [PATCH v4 2/3] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
In-Reply-To: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
controller, MT7622 limits message numbers to 255, and does not
support 4GB DMA mode.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index 9c86424..ff7bf37 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -7,6 +7,7 @@ Required properties:
       "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for MediaTek MT2701
       "mediatek,mt6577-i2c": for MediaTek MT6577
       "mediatek,mt6589-i2c": for MediaTek MT6589
+      "mediatek,mt7622-i2c": for MediaTek MT7622
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
       "mediatek,mt8173-i2c": for MediaTek MT8173
   - reg: physical base address of the controller and dma base, length of memory
-- 
1.8.1.1
