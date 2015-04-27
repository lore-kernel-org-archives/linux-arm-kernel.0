From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:26 +0200
Subject: [PATCH 02/10] ARM: shmobile: r8a7778 dtsi: Use generic names for
 device nodes
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430139334-15272-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 868f9730953350e9..7ce9f5fd586504f2 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -68,7 +68,7 @@
 	};
 
 	/* irqpin: IRQ0 - IRQ3 */
-	irqpin: irqpin at fe78001c {
+	irqpin: interrupt-controller at fe78001c {
 		compatible = "renesas,intc-irqpin-r8a7778", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
1.9.1
