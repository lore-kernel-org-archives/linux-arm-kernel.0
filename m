From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Oct 2017 13:05:59 +0200
Subject: [PATCH v2 09/10] arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback
 compat string
In-Reply-To: <20171013110600.6858-1-horms+renesas@verge.net.au>
References: <20171013110600.6858-1-horms+renesas@verge.net.au>
Message-ID: <20171013110600.6858-10-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen3 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7795 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d5cfd1a1c539..15ef292a8d9f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -220,7 +220,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -235,7 +235,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -250,7 +250,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -265,7 +265,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -280,7 +280,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -295,7 +295,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -310,7 +310,7 @@
 
 		gpio6: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -325,7 +325,7 @@
 
 		gpio7: gpio at e6055800 {
 			compatible = "renesas,gpio-r8a7795",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055800 0 0x50>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.11.0
