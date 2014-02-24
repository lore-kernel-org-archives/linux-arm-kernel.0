From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Feb 2014 17:29:06 +0100
Subject: [PATCH] ARM: sun6i: dt: Fix mod0 compatible
Message-ID: <1393259346-6074-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module 0 clock compatibles were changed between the time the patch was sent
and it was merged. Update the compatibles.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index af6f87c..42f310a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -200,7 +200,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi0";
@@ -208,7 +208,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi1";
@@ -216,7 +216,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi2";
@@ -224,7 +224,7 @@
 
 		spi3_clk: clk at 01c200ac {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi3";
-- 
1.9.0
