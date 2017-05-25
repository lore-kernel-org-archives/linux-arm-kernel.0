From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 25 May 2017 12:02:40 +0800
Subject: [PATCH v4 2/9] dt-bindings: arm: mediatek: add bindings for mediatek
 MT7623a SoC Platform
In-Reply-To: <cover.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
Message-ID: <ceeb1ff1b26437abcd13f6e646d12209006c0ce2.1495683769.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This adds DT binding documentation for Mediatek MT7623a

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
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
