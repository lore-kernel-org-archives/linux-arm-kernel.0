From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 01:42:28 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add resets properties
Message-ID: <1508776949-4995-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets properties to all nodes that have reset lines.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  |  9 +++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi |  9 +++++++++
 5 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index c0cd300..01fc3e1 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -71,6 +71,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -81,6 +82,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -91,6 +93,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -101,6 +104,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -127,6 +131,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -140,6 +145,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -153,6 +159,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
 		};
 
@@ -166,6 +173,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -319,6 +327,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 095a364..7955c3a 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -79,6 +79,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -89,6 +90,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -99,6 +101,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -109,6 +112,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -135,6 +139,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -148,6 +153,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -161,6 +167,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <100000>;
 		};
 
@@ -174,6 +181,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -187,6 +195,7 @@
 			#size-cells = <0>;
 			interrupts = <0 25 4>;
 			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
 		};
 
@@ -198,6 +207,7 @@
 			#size-cells = <0>;
 			interrupts = <0 26 4>;
 			clocks = <&peri_clk 10>;
+			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
 		};
 
@@ -338,6 +348,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index dba944f..6589b8a 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -166,6 +166,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -176,6 +177,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -186,6 +188,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -196,6 +199,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -222,6 +226,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -235,6 +240,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -248,6 +254,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <100000>;
 		};
 
@@ -261,6 +268,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -274,6 +282,7 @@
 			#size-cells = <0>;
 			interrupts = <0 25 4>;
 			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
 		};
 
@@ -285,6 +294,7 @@
 			#size-cells = <0>;
 			interrupts = <0 26 4>;
 			clocks = <&peri_clk 10>;
+			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
 		};
 
@@ -399,6 +409,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index a745437..d82d6d8 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -173,6 +173,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -183,6 +184,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -193,6 +195,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -203,6 +206,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -232,6 +236,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -245,6 +250,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -258,6 +264,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <100000>;
 		};
 
@@ -271,6 +278,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -282,6 +290,7 @@
 			#size-cells = <0>;
 			interrupts = <0 45 4>;
 			clocks = <&peri_clk 8>;
+			resets = <&peri_rst 8>;
 			clock-frequency = <400000>;
 		};
 
@@ -293,6 +302,7 @@
 			#size-cells = <0>;
 			interrupts = <0 25 4>;
 			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
 		};
 
@@ -304,6 +314,7 @@
 			#size-cells = <0>;
 			interrupts = <0 26 4>;
 			clocks = <&peri_clk 10>;
+			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
 		};
 
@@ -425,6 +436,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index df6d870..7188536 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -71,6 +71,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -81,6 +82,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -91,6 +93,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -101,6 +104,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -131,6 +135,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -144,6 +149,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -157,6 +163,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
 		};
 
@@ -170,6 +177,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -323,6 +331,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand2cs>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
-- 
2.7.4
