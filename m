From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  8 Aug 2017 10:39:21 +0200
Subject: [PATCH 03/10] ARM: dts: r8a7743: Use R-Car GPIO Gen2 fallback compat
 string
In-Reply-To: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1502181568-12299-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7743 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index f62e8587f1a8..e4c0c9d1bfad 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -67,7 +67,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -82,7 +82,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -97,7 +97,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -112,7 +112,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -127,7 +127,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -142,7 +142,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -157,7 +157,7 @@
 
 		gpio6: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -172,7 +172,7 @@
 
 		gpio7: gpio at e6055800 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055800 0 0x50>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.1.4
