From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 Jun 2016 10:21:19 +0100
Subject: [PATCH v3 04/20] ARM: dts: STiH416: Supply PWM Capture IRQs
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Message-ID: <20160608092135.21184-5-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 82091072..28d84c71 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -475,6 +475,7 @@
 			status		= "okay";
 			#pwm-cells	= <2>;
 			reg		= <0xfed10000 0x68>;
+			interrupts      = <GIC_SPI 200 IRQ_TYPE_NONE>;
 
 			pinctrl-names	= "default";
 			pinctrl-0 = 	<&pinctrl_pwm0_chan0_default
@@ -494,6 +495,7 @@
 			status		= "disabled";
 			#pwm-cells	= <2>;
 			reg		= <0xfe510000 0x68>;
+			interrupts      = <GIC_SPI 202 IRQ_TYPE_NONE>;
 
 			pinctrl-names	= "default";
 			pinctrl-0	= <&pinctrl_pwm1_chan0_default
-- 
2.8.3
