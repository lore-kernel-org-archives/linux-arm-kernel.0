From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 01:42:29 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: add resets properties
In-Reply-To: <1508776949-4995-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508776949-4995-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1508776949-4995-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resets properties to all nodes that have reset lines.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 0ae316e..1c63d0a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -125,6 +125,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -135,6 +136,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -145,6 +147,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -155,6 +158,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -203,6 +207,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -216,6 +221,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -226,6 +232,7 @@
 			#size-cells = <0>;
 			interrupts = <0 43 4>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
 		};
 
@@ -239,6 +246,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -252,6 +260,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c4>;
 			clocks = <&peri_clk 8>;
+			resets = <&peri_rst 8>;
 			clock-frequency = <100000>;
 		};
 
@@ -262,6 +271,7 @@
 			#size-cells = <0>;
 			interrupts = <0 25 4>;
 			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
 		};
 
@@ -314,6 +324,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
+			resets = <&sys_rst 4>;
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
@@ -454,6 +465,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 23ea35f..5c81070 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -231,6 +231,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -241,6 +242,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -251,6 +253,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -261,6 +264,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -303,6 +307,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -316,6 +321,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -326,6 +332,7 @@
 			#size-cells = <0>;
 			interrupts = <0 43 4>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
 		};
 
@@ -339,6 +346,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -352,6 +360,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c4>;
 			clocks = <&peri_clk 8>;
+			resets = <&peri_rst 8>;
 			clock-frequency = <100000>;
 		};
 
@@ -362,6 +371,7 @@
 			#size-cells = <0>;
 			interrupts = <0 25 4>;
 			clocks = <&peri_clk 9>;
+			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
 		};
 
@@ -419,6 +429,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
+			resets = <&sys_rst 4>;
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
@@ -510,6 +521,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index f55b14b..48e7331 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -153,6 +153,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
+			resets = <&peri_rst 0>;
 		};
 
 		serial1: serial at 54006900 {
@@ -163,6 +164,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
+			resets = <&peri_rst 1>;
 		};
 
 		serial2: serial at 54006a00 {
@@ -173,6 +175,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
+			resets = <&peri_rst 2>;
 		};
 
 		serial3: serial at 54006b00 {
@@ -183,6 +186,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
+			resets = <&peri_rst 3>;
 		};
 
 		gpio: gpio at 55000000 {
@@ -214,6 +218,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
+			resets = <&peri_rst 4>;
 			clock-frequency = <100000>;
 		};
 
@@ -227,6 +232,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
+			resets = <&peri_rst 5>;
 			clock-frequency = <100000>;
 		};
 
@@ -240,6 +246,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
+			resets = <&peri_rst 6>;
 			clock-frequency = <100000>;
 		};
 
@@ -253,6 +260,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
+			resets = <&peri_rst 7>;
 			clock-frequency = <100000>;
 		};
 
@@ -264,6 +272,7 @@
 			#size-cells = <0>;
 			interrupts = <0 26 4>;
 			clocks = <&peri_clk 10>;
+			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
 		};
 
@@ -321,6 +330,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
+			resets = <&sys_rst 4>;
 			bus-width = <8>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
@@ -405,6 +415,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clocks = <&sys_clk 2>;
+			resets = <&sys_rst 2>;
 		};
 	};
 };
-- 
2.7.4
