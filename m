From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Nov 2013 08:15:04 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use r8a7740 suffix for INTC compat string
In-Reply-To: <20131127231450.29081.98054.sendpatchset@w520>
References: <20131127231450.29081.98054.sendpatchset@w520>
Message-ID: <20131127231504.29081.74299.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7740" to the compatible string for the
IRQ pins in case of r8a7740 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7740.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7740.dtsi
+++ work/arch/arm/boot/dts/r8a7740.dtsi	2013-11-28 07:35:58.000000000 +0900
@@ -41,7 +41,7 @@
 
 	/* irqpin0: IRQ0 - IRQ7 */
 	irqpin0: irqpin at e6900000 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900000 4>,
@@ -62,7 +62,7 @@
 
 	/* irqpin1: IRQ8 - IRQ15 */
 	irqpin1: irqpin at e6900004 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900004 4>,
@@ -83,7 +83,7 @@
 
 	/* irqpin2: IRQ16 - IRQ23 */
 	irqpin2: irqpin at e6900008 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900008 4>,
@@ -104,7 +104,7 @@
 
 	/* irqpin3: IRQ24 - IRQ31 */
 	irqpin3: irqpin at e690000c {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe690000c 4>,
