From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 26 Jun 2017 14:11:40 +0800
Subject: [PATCH v2 1/3] dt-bindings: adc: mt7622: add binding document
In-Reply-To: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1498457502-3669-2-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds mt7622 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
index 68c45cb..64dc484 100644
--- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
@@ -12,6 +12,7 @@ for the Thermal Controller which holds a phandle to the AUXADC.
 Required properties:
   - compatible: Should be one of:
     - "mediatek,mt2701-auxadc": For MT2701 family of SoCs
+    - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
     - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
   - reg: Address range of the AUXADC unit.
   - clocks: Should contain a clock specifier for each entry in clock-names
-- 
1.7.9.5
