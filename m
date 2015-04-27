From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:30 +0200
Subject: [PATCH 06/10] ARM: shmobile: sh73a0 dtsi: Use generic names for
 device nodes
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430139334-15272-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 45b539ce4d352035..0bdb1da60487b431 100644
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
1.9.1
