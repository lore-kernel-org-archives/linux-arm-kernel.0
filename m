From: dawei.chien@mediatek.com (Dawei Chien)
Date: Thu, 7 Jul 2016 17:06:24 +0800
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for Mediatek
 thermal controller
In-Reply-To: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1467882386-40544-2-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree binding documentation for the mediatek thermal
controller found on Mediatek MT2701.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 .../bindings/thermal/mediatek-thermal.txt          |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 81f9a51..bb55e79 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -8,7 +8,7 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
 is also needed.
 
 Required properties:
-- compatible: "mediatek,mt8173-thermal"
+- compatible: "mediatek,mt8173-thermal" or "mediatek,mt2701-thermal"
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
1.7.9.5
