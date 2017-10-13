From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 13:06:00 +0200
Subject: [PATCH v2 10/10] arm64: dts: r8a7796: Use R-Car GPIO Gen3 fallback
 compat string
In-Reply-To: <20171013110600.6858-1-horms+renesas@verge.net.au>
References: <20171013110600.6858-1-horms+renesas@verge.net.au>
Message-ID: <20171013110600.6858-11-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen3 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7796 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 8085fd91811e..f2b2e40c655e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -214,7 +214,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -229,7 +229,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -244,7 +244,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -259,7 +259,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -274,7 +274,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -289,7 +289,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -304,7 +304,7 @@
 
 		gpio6: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -319,7 +319,7 @@
 
 		gpio7: gpio at e6055800 {
 			compatible = "renesas,gpio-r8a7796",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055800 0 0x50>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.11.0
