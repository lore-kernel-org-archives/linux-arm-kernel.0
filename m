From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 31 Jul 2017 16:22:11 +0800
Subject: [PATCH 1/3] dt-bindings: pinctrl: mt2712: add binding document
In-Reply-To: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1501489333-23145-2-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds mt2712 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index 17631d0..37d7447 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -5,6 +5,7 @@ The Mediatek's Pin controller is used to control SoC pins.
 Required properties:
 - compatible: value should be one of the following.
 	"mediatek,mt2701-pinctrl", compatible with mt2701 pinctrl.
+	"mediatek,mt2712-pinctrl", compatible with mt2712 pinctrl.
 	"mediatek,mt6397-pinctrl", compatible with mt6397 pinctrl.
 	"mediatek,mt7623-pinctrl", compatible with mt7623 pinctrl.
 	"mediatek,mt8127-pinctrl", compatible with mt8127 pinctrl.
-- 
1.7.9.5
