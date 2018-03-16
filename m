From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:09 +0100
Subject: [PATCH 12/47] ARM: dts: r8a7791: consistently use single space after =
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <5025c78b3b69914d4da8e75cf2390329cf04ca95.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use a single space after a =.

This patch removes instances where a tab or multiple spaces are used
instead.  It also avoids running over 80 columns in width in one of the
lines where whitespace is updated.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 75 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8266a9b7cafd..38a9b8cb736d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -237,9 +237,9 @@
 	};
 
 	thermal: thermal at e61f0000 {
-		compatible =	"renesas,thermal-r8a7791",
-				"renesas,rcar-gen2-thermal",
-				"renesas,rcar-thermal";
+		compatible = "renesas,thermal-r8a7791",
+			     "renesas,rcar-gen2-thermal",
+			     "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
@@ -375,20 +375,20 @@
 	audma0: dma-controller at ec700000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
 		reg = <0 0xec700000 0 0x10000>;
-		interrupts =	<GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -405,20 +405,20 @@
 	audma1: dma-controller at ec720000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
 		reg = <0 0xec720000 0 0x10000>;
-		interrupts =	<GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
-				 GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -1487,12 +1487,13 @@
 		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
 		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
 		 */
-		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
-		reg =	<0 0xec500000 0 0x1000>, /* SCU */
-			<0 0xec5a0000 0 0x100>,  /* ADG */
-			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x280>,  /* SSI */
-			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+		compatible = "renesas,rcar_sound-r8a7791",
+			     "renesas,rcar_sound-gen2";
+		reg = <0 0xec500000 0 0x1000>, /* SCU */
+		      <0 0xec5a0000 0 0x100>,  /* ADG */
+		      <0 0xec540000 0 0x1000>, /* SSIU */
+		      <0 0xec541000 0 0x280>,  /* SSI */
+		      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&cpg CPG_MOD 1005>,
-- 
2.11.0
