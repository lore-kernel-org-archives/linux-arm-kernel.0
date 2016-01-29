From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:32:02 +0100
Subject: [PATCH v4 1/7] ARM: dts: r8a7778: Add SCIF fallback compatibility
 strings
In-Reply-To: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
References: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454059928-975-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7778.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index fc5e7243467abe3c..8ea1792c51460fc4 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -297,7 +297,8 @@
 	};
 
 	scif0: serial at ffe40000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
@@ -307,7 +308,8 @@
 	};
 
 	scif1: serial at ffe41000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
@@ -317,7 +319,8 @@
 	};
 
 	scif2: serial at ffe42000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
@@ -327,7 +330,8 @@
 	};
 
 	scif3: serial at ffe43000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
@@ -337,7 +341,8 @@
 	};
 
 	scif4: serial at ffe44000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
@@ -347,7 +352,8 @@
 	};
 
 	scif5: serial at ffe45000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
-- 
1.9.1
