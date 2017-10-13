From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 13:05:56 +0200
Subject: [PATCH v2 06/10] ARM: dts: r8a7792: Use R-Car GPIO Gen2 fallback
 compat string
In-Reply-To: <20171013110600.6858-1-horms+renesas@verge.net.au>
References: <20171013110600.6858-1-horms+renesas@verge.net.au>
Message-ID: <20171013110600.6858-7-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7792 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 549eafe8ff12..56570d1ce5f6 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -147,7 +147,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -162,7 +162,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -177,7 +177,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -192,7 +192,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -207,7 +207,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -222,7 +222,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -237,7 +237,7 @@
 
 		gpio6: gpio at e6055100 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055100 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -252,7 +252,7 @@
 
 		gpio7: gpio at e6055200 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055200 0 0x50>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -267,7 +267,7 @@
 
 		gpio8: gpio at e6055300 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055300 0 0x50>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -282,7 +282,7 @@
 
 		gpio9: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -297,7 +297,7 @@
 
 		gpio10: gpio at e6055500 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055500 0 0x50>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -312,7 +312,7 @@
 
 		gpio11: gpio at e6055600 {
 			compatible = "renesas,gpio-r8a7792",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055600 0 0x50>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.11.0
