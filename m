From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 Jun 2016 10:21:17 +0100
Subject: [PATCH v3 02/20] ARM: dts: STiH407: Supply PWM Capture IRQ
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Message-ID: <20160608092135.21184-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 0723900..37a3bcc 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -664,6 +664,7 @@
 			compatible	= "st,sti-pwm";
 			#pwm-cells	= <2>;
 			reg		= <0x9810000 0x68>;
+			interrupts      = <GIC_SPI 128 IRQ_TYPE_NONE>;
 			pinctrl-names	= "default";
 			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
 			clock-names	= "pwm";
-- 
2.8.3
