From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 May 2018 16:35:43 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77995: don't use deprecated renesas,
 gpio-rcar
Message-ID: <20180514143543.16590-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compat string renesas,gpio-rcar has been deprecated since v4.14,
the same release that r8a77990 SoC support was added. Thus
renesas,gpio-rcar can safely be removed without any risk of behaviour
changes between old and new mainline kernels and DTBs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

 Based on renesas-devel-20180511-v4.17-rc4

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 2506f46293e8..f3426266b5ea 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -88,8 +88,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -104,8 +103,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -120,8 +118,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -136,8 +133,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -152,8 +148,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -168,8 +163,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -184,8 +178,7 @@
 
 		gpio6: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.11.0
