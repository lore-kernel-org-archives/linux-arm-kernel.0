From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 2 Oct 2015 23:05:17 +0800
Subject: [PATCH v4 1/3] dt-bindings: add more MediaTek SoC to mtk-timer binding
In-Reply-To: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1443798319-45744-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible string for mt8127, mt8135 and mt8173 and sort
the list.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 53a3029..64083bc 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -3,10 +3,12 @@ Mediatek MT6577, MT6572 and MT6589 Timers
 
 Required properties:
 - compatible should contain:
-	* "mediatek,mt6589-timer" for MT6589 compatible timers
 	* "mediatek,mt6580-timer" for MT6580 compatible timers
-	* "mediatek,mt6577-timer" for all compatible timers (MT6589, MT6580,
-		MT6577)
+	* "mediatek,mt6589-timer" for MT6589 compatible timers
+	* "mediatek,mt8127-timer" for MT8127 compatible timers
+	* "mediatek,mt8135-timer" for MT8135 compatible timers
+	* "mediatek,mt8173-timer" for MT8173 compatible timers
+	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
 - reg: Should contain location and length for timers register.
 - clocks: Clocks driving the timer hardware. This list should include two
 	clocks. The order is system clock and as second clock the RTC clock.
-- 
1.9.1
