From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 23 Feb 2018 18:16:21 +0800
Subject: [PATCH v1 01/19] dt-bindings: pinctrl: mediatek: use - instead of _
 in examples
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
Message-ID: <44956252092b19ece67c5a0df1492a5baeaa4dab.1519378871.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

It should be good that no use "_" is in examples. Consequently,
those nodes in certain files which have an inappropriate name containing
"_" are all being replaced with "-".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-gpio at vger.kernel.org
Cc: devicetree at vger.kernel.org
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index afa8a18..e7d6f81 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -76,12 +76,12 @@ Examples:
 
 ...
 {
-	syscfg_pctl_a: syscfg_pctl_a at 10005000 {
+	syscfg_pctl_a: syscfg-pctl-a at 10005000 {
 		compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
 		reg = <0 0x10005000 0 0x1000>;
 	};
 
-	syscfg_pctl_b: syscfg_pctl_b at 1020c020 {
+	syscfg_pctl_b: syscfg-pctl-b at 1020c020 {
 		compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
 		reg = <0 0x1020C020 0 0x1000>;
 	};
-- 
2.7.4
