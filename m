From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:34:54 +0900
Subject: [PATCH 2/4] ARM: shmobile: r8a7791 dtsi: Drop "renesas,
 rcar_sound" compatible value
In-Reply-To: <cover.1421371490.git.horms+renesas@verge.net.au>
References: <cover.1421371490.git.horms+renesas@verge.net.au>
Message-ID: <f49cd2b3d2caf075d78fa1948fda1d7ed246d1eb.1421371490.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The "renesas,rcar_sound" compatible property value was never processed
nor documented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 77c0bee..7fdd1a6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1382,7 +1382,7 @@
 
 	rcar_sound: rcar_sound at ec500000 {
 		#sound-dai-cells = <1>;
-		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
+		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
2.1.4
