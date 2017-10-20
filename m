From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:30 +0200
Subject: [PATCH 03/42] ARM: dts: r8a7790: Use generic node name for VSP1 nodes
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <9f77b4801944b6c74b871f9252e09177e273212c.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the preferred generic node name instead of the specific name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 081cf5cdb13b..17a48199b7a9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1014,7 +1014,7 @@
 		status = "disabled";
 	};
 
-	vsp1 at fe920000 {
+	vsp at fe920000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
@@ -1023,7 +1023,7 @@
 		resets = <&cpg 130>;
 	};
 
-	vsp1 at fe928000 {
+	vsp at fe928000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
@@ -1032,7 +1032,7 @@
 		resets = <&cpg 131>;
 	};
 
-	vsp1 at fe930000 {
+	vsp at fe930000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
@@ -1041,7 +1041,7 @@
 		resets = <&cpg 128>;
 	};
 
-	vsp1 at fe938000 {
+	vsp at fe938000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0
