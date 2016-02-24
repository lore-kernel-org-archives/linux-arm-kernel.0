From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 11:29:05 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7790: use fallback jpu compatibility string
In-Reply-To: <1456280946-14859-1-git-send-email-horms+renesas@verge.net.au>
References: <1456280946-14859-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1456280946-14859-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device trees.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ba4c2530d79f..e785831c30f3 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -989,7 +989,7 @@
 	};
 
 	jpu: jpeg-codec at fe980000 {
-		compatible = "renesas,jpu-r8a7790";
+		compatible = "renesas,jpu-r8a7790", "renesas,rcar-gen2-jpu";
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_JPU>;
-- 
2.1.4
