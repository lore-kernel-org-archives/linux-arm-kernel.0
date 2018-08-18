From: ryder.lee@mediatek.com (Ryder Lee)
Date: Sun, 19 Aug 2018 00:02:28 +0800
Subject: [PATCH v1 5/5] dt-bindings: arm: mediatek: add support for bananapi
 BPI-R64 board
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
Message-ID: <c90763cd9800a368f47754002585704a29a437bb.1534607107.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update binding document for bananapi BPI-R64 board being supported.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 8f260e5..d30f6ce 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -57,6 +57,9 @@ Supported boards:
 - Reference board variant 1 for MT7622:
     Required root node properties:
       - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
+- Bananapi BPI-R64 for MT7622:
+    Required root node properties:
+      - compatible = "bananapi,bpi-r64", "mediatek,mt7622";
 - Reference board for MT7623a with eMMC:
     Required root node properties:
       - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
-- 
1.9.1
