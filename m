From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:39 +0900
Subject: [PATCH 10/31] ARM: shmobile: r8a7778 dtsi: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <b38150fae0164d363c852d6b782ab7083697c6d2.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 868f97309533..7ce9f5fd5865 100644
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
2.1.4
