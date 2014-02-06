From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:51 +0900
Subject: [PATCH 16/17] ARM: shmobile: r8a7790: Fix serial ports DT compatible
 strings
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <59d2b5173bbe8dbc324e34263ceae4d6131058f2.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Remove the -generic suffix that has been added by mistake from the
serial port compatible strings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0914921..51c8978 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -301,7 +301,7 @@
 	};
 
 	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 4>;
@@ -311,7 +311,7 @@
 	};
 
 	scifa1: serial at e6c50000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 4>;
@@ -321,7 +321,7 @@
 	};
 
 	scifa2: serial at e6c60000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 4>;
@@ -331,7 +331,7 @@
 	};
 
 	scifb0: serial at e6c20000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 4>;
@@ -341,7 +341,7 @@
 	};
 
 	scifb1: serial at e6c30000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 4>;
@@ -351,7 +351,7 @@
 	};
 
 	scifb2: serial at e6ce0000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 4>;
@@ -361,7 +361,7 @@
 	};
 
 	scif0: serial at e6e60000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		compatible = "renesas,scif-r8a7790", "renesas,scif";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 4>;
@@ -371,7 +371,7 @@
 	};
 
 	scif1: serial at e6e68000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		compatible = "renesas,scif-r8a7790", "renesas,scif";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 4>;
@@ -381,7 +381,7 @@
 	};
 
 	hscif0: serial at e62c0000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 4>;
@@ -391,7 +391,7 @@
 	};
 
 	hscif1: serial at e62c8000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
 		interrupt-parent = <&gic>;
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 4>;
-- 
1.8.5.2
