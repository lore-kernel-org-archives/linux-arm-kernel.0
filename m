From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 10:34:55 +0100
Subject: [PATCH v4 04/17] ARM: dts: STiH416: Declare PWM Capture data lines
 via Pinctrl
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Message-ID: <20160816093508.28307-5-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 051fc16..252b677 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -221,11 +221,14 @@
 				pinctrl_pwm1_chan0_default: pwm1-0-default {
 					st,pins {
 						pwm-out    = <&pio3 0 ALT1 OUT>;
+						pwm-capturein = <&pio3 2 ALT1 IN>;
+
 					};
 				};
 				pinctrl_pwm1_chan1_default: pwm1-1-default {
 					st,pins {
 						pwm-out    = <&pio4 4 ALT1 OUT>;
+						pwm-capturein = <&pio4 3 ALT1 IN>;
 					};
 				};
 				pinctrl_pwm1_chan2_default: pwm1-2-default {
@@ -337,6 +340,7 @@
 				pinctrl_pwm0_chan0_default: pwm0-0-default {
 					st,pins {
 						pwm-out    = <&pio9 7 ALT2 OUT>;
+						pwm-capturein = <&pio9 6 ALT2 IN>;
 					};
 				};
 			};
@@ -576,6 +580,7 @@
 				pinctrl_pwm0_chan1_default: pwm0-1-default {
 					st,pins {
 						pwm-out    = <&pio13 2 ALT2 OUT>;
+						pwm-capturein = <&pio13 1 ALT2 IN>;
 					};
 				};
 				pinctrl_pwm0_chan2_default: pwm0-2-default {
-- 
2.9.0
