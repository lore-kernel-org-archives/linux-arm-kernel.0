From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:38 +0900
Subject: [PATCH 64/69] ARM: shmobile: Use sh73a0 suffix for INTC compat string
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <8bb44445b08d1068a0ca5f72159d8e373f810155.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-sh73a0" to the compatible string for the
IRQ pins in case of sh73a0 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 29d2ee6..241c8cd 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
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
-- 
1.8.4
