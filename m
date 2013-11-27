From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Nov 2013 08:14:57 +0900
Subject: [PATCH 01/04] ARM: shmobile: Use sh73a0 suffix for INTC compat string
In-Reply-To: <20131127231450.29081.98054.sendpatchset@w520>
References: <20131127231450.29081.98054.sendpatchset@w520>
Message-ID: <20131127231457.29081.22706.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-sh73a0" to the compatible string for the
IRQ pins in case of sh73a0 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/sh73a0.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0001/arch/arm/boot/dts/sh73a0.dtsi
+++ work/arch/arm/boot/dts/sh73a0.dtsi	2013-11-28 07:38:21.000000000 +0900
@@ -47,7 +47,7 @@
 	};
 
 	irqpin0: irqpin at e6900000 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900000 4>,
@@ -67,7 +67,7 @@
 	};
 
 	irqpin1: irqpin at e6900004 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900004 4>,
@@ -88,7 +88,7 @@
 	};
 
 	irqpin2: irqpin at e6900008 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe6900008 4>,
@@ -108,7 +108,7 @@
 	};
 
 	irqpin3: irqpin at e690000c {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0xe690000c 4>,
