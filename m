From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:12 -0300
Subject: [PATCH RFC 8/8] ARM: sun4i: mod0 clocks
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-9-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds all the mod0 clocks present on sun4i to its device tree

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 620290b..90493e3 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -180,6 +180,111 @@
 				"apb1_uart4", "apb1_uart5", "apb1_uart6",
 				"apb1_uart7";
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
+		spi1: spi0 at 01c200a4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-mod0-clk";
+			reg = <0x01c200a4 0x4>;
+			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
+		};
+
+		spi2: spi0 at 01c200a8 {
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
 
 	soc at 01c20000 {
-- 
1.8.3.3
