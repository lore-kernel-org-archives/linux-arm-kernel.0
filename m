From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:32:08 +0100
Subject: [PATCH v4 7/7] arm64: dts: r8a7795: Add SCIF fallback compatibility
 strings
In-Reply-To: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
References: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454059928-975-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 119549e6502d0578..e5c38d1a551df78a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -474,7 +474,9 @@
 		};
 
 		hscif0: serial at e6540000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>;
@@ -486,7 +488,9 @@
 		};
 
 		hscif1: serial at e6550000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>;
@@ -498,7 +502,9 @@
 		};
 
 		hscif2: serial at e6560000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>;
@@ -510,7 +516,9 @@
 		};
 
 		hscif3: serial at e66a0000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>;
@@ -522,7 +530,9 @@
 		};
 
 		hscif4: serial at e66b0000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe66b0000 0 96>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 516>;
@@ -534,7 +544,8 @@
 		};
 
 		scif0: serial at e6e60000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>;
@@ -546,7 +557,8 @@
 		};
 
 		scif1: serial at e6e68000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>;
@@ -558,7 +570,8 @@
 		};
 
 		scif2: serial at e6e88000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 310>;
@@ -570,7 +583,8 @@
 		};
 
 		scif3: serial at e6c50000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>;
@@ -582,7 +596,8 @@
 		};
 
 		scif4: serial at e6c40000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>;
@@ -594,7 +609,8 @@
 		};
 
 		scif5: serial at e6f30000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6f30000 0 64>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 202>;
-- 
1.9.1
