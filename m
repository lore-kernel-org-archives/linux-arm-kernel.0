From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:40 +0900
Subject: [PATCH 11/31] ARM: shmobile: r8a7779 dtsi: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <a37771c6e36f2db84a67074d35d7519f75939b43.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c2219b9f3eb..5c8071e87ae9 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -148,7 +148,7 @@
 		interrupt-controller;
 	};
 
-	irqpin0: irqpin at fe780010 {
+	irqpin0: interrupt-controller at fe780010 {
 		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
-- 
2.1.4
