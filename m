From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:19 +1000
Subject: [PATCH 01/22] ARM: dts: r8a7790: use fallback jpu compatibility string
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <1c4b68fdd52e05730591682bc62042cead6f5af3.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device trees.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 283698fc0fea..60db8e4f5790 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -990,7 +990,7 @@
 	};
 
 	jpu: jpeg-codec at fe980000 {
-		compatible = "renesas,jpu-r8a7790";
+		compatible = "renesas,jpu-r8a7790", "renesas,rcar-gen2-jpu";
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_JPU>;
-- 
2.7.0.rc3.207.g0ac5344
