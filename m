From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 09:47:18 +0900
Subject: [PATCH 16/19] ARM: shmobile: r8a7778: tidyup SSI resource region
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
Message-ID: <23640ff2eff0dec2016dd097b1b04c817a4ffd3f.1442536920.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4b1fa9f42ad5..4f8e07811746 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -239,7 +239,7 @@
 		#sound-dai-cells = <1>;
 		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
 		reg =	<0xffd90000 0x1000>,	/* SRU */
-			<0xffd91000 0x1240>,	/* SSI */
+			<0xffd91000 0x240>,	/* SSI */
 			<0xfffe0000 0x24>;	/* ADG */
 		clocks = <&mstp3_clks R8A7778_CLK_SSI8>,
 			<&mstp3_clks R8A7778_CLK_SSI7>,
-- 
2.1.4
