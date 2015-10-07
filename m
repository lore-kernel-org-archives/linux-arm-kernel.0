From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:57:52 +0900
Subject: [PATCH 15/28] ARM: shmobile: r8a7791: tidyup SSI resource region
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <8c3f903bd362328aac997aba1adfea59e337918a.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 831525dd39a6..3b8e26dde36d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1649,7 +1649,7 @@
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x1280>, /* SSI */
+			<0 0xec541000 0 0x280>,  /* SSI */
 			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-- 
2.1.4
