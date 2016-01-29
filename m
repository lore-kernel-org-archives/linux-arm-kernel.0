From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:32:03 +0100
Subject: [PATCH v4 2/7] ARM: dts: r8a7779: Add SCIF fallback compatibility
 strings
In-Reply-To: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
References: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454059928-975-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7779.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 93f3fdf95e31ccad..1671839f55a6349c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -211,7 +211,8 @@
 	};
 
 	scif0: serial at ffe40000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
@@ -221,7 +222,8 @@
 	};
 
 	scif1: serial at ffe41000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
@@ -231,7 +233,8 @@
 	};
 
 	scif2: serial at ffe42000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
@@ -241,7 +244,8 @@
 	};
 
 	scif3: serial at ffe43000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
@@ -251,7 +255,8 @@
 	};
 
 	scif4: serial at ffe44000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
@@ -261,7 +266,8 @@
 	};
 
 	scif5: serial at ffe45000 {
-		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		compatible = "renesas,scif-r8a7779", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
-- 
1.9.1
