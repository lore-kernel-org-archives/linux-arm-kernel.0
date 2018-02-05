From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 5 Feb 2018 16:11:51 +0800
Subject: [PATCH 1/2] dt-bindings: thermal: add binding for MT7622 SoC
Message-ID: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add devicetree bindings for MediaTek MT7622 thermal controller

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 0d73ea5..41d6a44 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -12,6 +12,7 @@ Required properties:
   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
+  - "mediatek,mt7622-thermal" : For MT7622 SoC
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
2.7.4
