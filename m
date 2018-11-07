From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 7 Nov 2018 15:10:16 +0800
Subject: [PATCH] dt-bindings: rng: update bindings for MT7629 SoC
Message-ID: <0f5fe0d5b6a9c81b3f4395a1007ed0ba2239ae45.1541574485.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates bindings for MT7629 RNG driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
index 366b99b..ffa6a66 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
@@ -1,9 +1,10 @@
 Device-Tree bindings for Mediatek random number generator
-found in Mediatek SoC family
+found in MediaTek SoC family
 
 Required properties:
 - compatible	    : Should be
 			"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" : for MT7622
+			"mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
 			"mediatek,mt7623-rng" : for MT7623
 - clocks	    : list of clock specifiers, corresponding to
 		      entries in clock-names property;
-- 
1.9.1
