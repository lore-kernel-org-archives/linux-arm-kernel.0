From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 12 May 2017 15:56:41 +0800
Subject: [PATCH v3 4/9] dt-bindings: arm: mediatek: add bindings for mediatek
 MT7623a SoC Platform
In-Reply-To: <cover.1494574682.git.sean.wang@mediatek.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
Message-ID: <1e21077e4676a8b2596ec5f04251905760147920.1494574682.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This adds DT binding documentation for Mediatek MT7623a

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 0924b62..412c6bd 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -13,6 +13,7 @@ compatible: Must contain one of
    "mediatek,mt6755"
    "mediatek,mt6795"
    "mediatek,mt7623" which is referred to MT7623N SoC
+   "mediatek,mt7623a"
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
-- 
2.7.4
