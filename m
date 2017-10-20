From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:31 +0200
Subject: [PATCH 04/42] ARM: dts: r8a7791: Use generic node name for VSP1 nodes
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <18e5500c1510c844d5c3071f06089b638326bc52.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the preferred generic node name instead of the specific name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 5a8a15847076..97bed8253bc3 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1073,7 +1073,7 @@
 		status = "disabled";
 	};
 
-	vsp1 at fe928000 {
+	vsp at fe928000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
@@ -1082,7 +1082,7 @@
 		resets = <&cpg 131>;
 	};
 
-	vsp1 at fe930000 {
+	vsp at fe930000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
@@ -1091,7 +1091,7 @@
 		resets = <&cpg 128>;
 	};
 
-	vsp1 at fe938000 {
+	vsp at fe938000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
