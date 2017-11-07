From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 7 Nov 2017 13:37:17 +0800
Subject: [PATCH v3 3/4] dt-bindings: iio: adc: update the doc for SAR ADC
In-Reply-To: <20171107053717.31948-1-yixun.lan@amlogic.com>
References: <20171107053717.31948-1-yixun.lan@amlogic.com>
Message-ID: <20171107053717.31948-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Update the doc as the SAR ADC modules doesn't require "sana" clock.

Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f413e82c8b83..1e6ee3deb4fa 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -15,7 +15,6 @@ Required properties:
 			- "clkin" for the reference clock (typically XTAL)
 			- "core" for the SAR ADC core clock
 		optional clocks:
-			- "sana" for the analog clock
 			- "adc_clk" for the ADC (sampling) clock
 			- "adc_sel" for the ADC (sampling) clock mux
 - vref-supply:	the regulator supply for the ADC reference voltage
-- 
2.14.1
