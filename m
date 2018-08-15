From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 15 Aug 2018 13:18:17 +0800
Subject: [PATCH 5/5] dt-bindings: arm: mediatek: add support for bananapi
 BPI-R64 board
In-Reply-To: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
References: <68c4ca0158518d6bf50f2f7becfcb87ff3ce158a.1534130854.git.ryder.lee@mediatek.com>
Message-ID: <93e3763cee209d7610307565a3ac02a0792417ae.1534130854.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update binding document for bananapi BPI-R64 board being supported.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..677fdcf 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -50,6 +50,9 @@ Supported boards:
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
