From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:17 +0100
Subject: [PATCH 20/47] ARM: dts: r8a7794: consistently use single space after =
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <b190cce35ff90e392f89a3d45e0814cdbfd7434c.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use a single space after a =.

This patch removes instances where a tab is used instead.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 106b4e1649ff..79263377ded3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -319,20 +319,20 @@
 	audma0: dma-controller at ec700000 {
 		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
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
 				  "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
 				  "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
@@ -1186,11 +1186,11 @@
 		 */
 		compatible = "renesas,rcar_sound-r8a7794",
 			     "renesas,rcar_sound-gen2";
-		reg =	<0 0xec500000 0 0x1000>, /* SCU */
-			<0 0xec5a0000 0 0x100>,  /* ADG */
-			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x280>,  /* SSI */
-			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
+		reg = <0 0xec500000 0 0x1000>, /* SCU */
+		      <0 0xec5a0000 0 0x100>,  /* ADG */
+		      <0 0xec540000 0 0x1000>, /* SSIU */
+		      <0 0xec541000 0 0x280>,  /* SSI */
+		      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&cpg CPG_MOD 1005>,
-- 
2.11.0
