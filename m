From: richard.genoud@gmail.com (Richard Genoud)
Date: Sun, 26 Apr 2015 12:15:38 +0200
Subject: [PATCH] ARM: sunxi: dts: Add A10 uarts pin muxing options
Message-ID: <1430043338-28982-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 has 8 uarts, only uart0 and uart1 where filled.
This patch adds all the missing uarts(2 to 7) pin muxing to the dtsi.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

Based on V4.0
uart4_a tested on cubieboard A10

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index eebb785..e83fd2c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -673,6 +673,90 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			uart2_pins_a: uart2 at 0 {
+				allwinner,pins = "PA2", "PA3";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_pins_b: uart2 at 1 {
+				allwinner,pins = "PI18", "PI19";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PG6", "PG7";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_b: uart3 at 1 {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart4_pins_a: uart4 at 0 {
+				allwinner,pins = "PG10", "PG11";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart4_pins_b: uart4 at 1 {
+				allwinner,pins = "PH4", "PH5";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart5_pins_a: uart5 at 0 {
+				allwinner,pins = "PH6", "PH7";
+				allwinner,function = "uart5";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart5_pins_b: uart5 at 1 {
+				allwinner,pins = "PI10", "PI11";
+				allwinner,function = "uart5";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart6_pins_a: uart6 at 0 {
+				allwinner,pins = "PA12", "PA13";
+				allwinner,function = "uart6";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart6_pins_b: uart6 at 1 {
+				allwinner,pins = "PI12", "PI13";
+				allwinner,function = "uart6";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart7_pins_a: uart7 at 0 {
+				allwinner,pins = "PA14", "PA15";
+				allwinner,function = "uart7";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart7_pins_b: uart7 at 1 {
+				allwinner,pins = "PI20", "PI21";
+				allwinner,function = "uart7";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			i2c0_pins_a: i2c0 at 0 {
 				allwinner,pins = "PB0", "PB1";
 				allwinner,function = "i2c0";
-- 
1.7.10.4
