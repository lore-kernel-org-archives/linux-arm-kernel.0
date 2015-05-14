From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:43 +0900
Subject: [PATCH 14/31] ARM: shmobile: sh73a0 dtsi: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <4239baee807bbd93e89eef184b2547f5ae902615.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index cde61b463b6a..11e17c5f26e2 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -90,7 +90,7 @@
 		status = "disabled";
 	};
 
-	irqpin0: irqpin at e6900000 {
+	irqpin0: interrupt-controller at e6900000 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -112,7 +112,7 @@
 		control-parent;
 	};
 
-	irqpin1: irqpin at e6900004 {
+	irqpin1: interrupt-controller at e6900004 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -134,7 +134,7 @@
 		control-parent;
 	};
 
-	irqpin2: irqpin at e6900008 {
+	irqpin2: interrupt-controller at e6900008 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -156,7 +156,7 @@
 		control-parent;
 	};
 
-	irqpin3: irqpin at e690000c {
+	irqpin3: interrupt-controller at e690000c {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
2.1.4
