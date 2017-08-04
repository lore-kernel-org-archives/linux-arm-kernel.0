From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 4 Aug 2017 15:14:07 +0800
Subject: [PATCH] dt-bindings: watchdog: mediatek: add support for MediaTek
 MT7623 and MT7622 SoC
Message-ID: <b0058a0a9f948f17edf3c1a476665c715922ebc3.1501830388.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This updates dt-binding documentation for MediaTek MT7622 and
MT7623 SoC. For the both SoCs supported all rely on the fallback
binding of the case with "mediatek,mt6589-wdt".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 6a00939..096bbfb 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -4,6 +4,8 @@ Required properties:
 
 - compatible should contain:
 	* "mediatek,mt2701-wdt" for MT2701 compatible watchdog timers
+	* "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
+	* "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
 	* "mediatek,mt6589-wdt" for all compatible watchdog timers (MT2701,
 		MT6589)
 
-- 
2.7.4
