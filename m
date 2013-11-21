From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 21 Nov 2013 09:42:29 +0900
Subject: [PATCH] ARM: shmobile: Fix r8a7791 GPIO resources in DTS
Message-ID: <20131121004229.16464.59215.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7791 GPIO resources are currently incorrect. Fix that
by making them match the information in the data sheet.

Tested with GPIO LED using Koelsch DT reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- 0021/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-11-20 17:28:26.000000000 +0900
@@ -49,9 +49,9 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	gpio0: gpio at ffc40000 {
+	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc40000 0 0x50>;
+		reg = <0 0xe6050000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -61,9 +61,9 @@
 		interrupt-controller;
 	};
 
-	gpio1: gpio at ffc41000 {
+	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc41000 0 0x50>;
+		reg = <0 0xe6051000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -73,9 +73,9 @@
 		interrupt-controller;
 	};
 
-	gpio2: gpio at ffc42000 {
+	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc42000 0 0x50>;
+		reg = <0 0xe6052000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -85,9 +85,9 @@
 		interrupt-controller;
 	};
 
-	gpio3: gpio at ffc43000 {
+	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc43000 0 0x50>;
+		reg = <0 0xe6053000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -97,9 +97,9 @@
 		interrupt-controller;
 	};
 
-	gpio4: gpio at ffc44000 {
+	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc44000 0 0x50>;
+		reg = <0 0xe6054000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -109,9 +109,9 @@
 		interrupt-controller;
 	};
 
-	gpio5: gpio at ffc45000 {
+	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45000 0 0x50>;
+		reg = <0 0xe6055000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -121,9 +121,9 @@
 		interrupt-controller;
 	};
 
-	gpio6: gpio at ffc45400 {
+	gpio6: gpio at e6055400 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45400 0 0x50>;
+		reg = <0 0xe6055400 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -133,9 +133,9 @@
 		interrupt-controller;
 	};
 
-	gpio7: gpio at ffc45800 {
+	gpio7: gpio at e6055800 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45800 0 0x50>;
+		reg = <0 0xe6055800 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
