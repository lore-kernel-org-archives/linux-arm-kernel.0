From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 7 Nov 2018 15:10:36 +0800
Subject: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
Message-ID: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates dt-binding documentation for MT7629 SoC

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 859dee1..8682d6a 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -8,6 +8,7 @@ Required properties:
 	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
 	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
 	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
+	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
 
 - reg : Specifies base physical address and size of the registers.
 
-- 
1.9.1
