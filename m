From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun, 29 Sep 2013 00:49:38 -0300
Subject: [PATCH 09/10] ARM: sun7i: dt: mod0 clocks
In-Reply-To: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1380426579-32458-10-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod0 clocks available on A20 to its device
tree. This list was created by looking at AW's code release.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c622e51..d75eb53 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -170,6 +170,111 @@
 				"apb1_uart2", "apb1_uart3", "apb1_uart4",
 				"apb1_uart5", "apb1_uart6", "apb1_uart7";
 		};
+
+		nand: nand at 01c20080 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20080 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		ms: ms at 01c20084 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20084 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		mmc0: mmc0 at 01c20088 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20088 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		mmc1: mmc1 at 01c2008c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2008c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		mmc2: mmc2 at 01c20090 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20090 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		mmc3: mmc3 at 01c20094 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20094 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		ts: ts at 01c20098 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c20098 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		ss: ss at 01c2009c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c2009c 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		spi0: spi0 at 01c200a0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		spi1: spi1 at 01c200a4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		spi2: spi2 at 01c200a8 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a8 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		pata: pata at 01c200ac {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200ac 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		ir0: ir0 at 01c200b0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b0 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		ir1: ir1 at 01c200b4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200b4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		spi3: spi3 at 01c200d4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200d4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.4
