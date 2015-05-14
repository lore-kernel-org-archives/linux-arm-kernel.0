From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:47 +0900
Subject: [PATCH 18/31] ARM: shmobile: armadillo800eva dts: Use generic names
 for device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <92d2434d8effe6160eb7f4fd0d01ef5b76930f2a.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

wm8978 -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 9bd0cb439f44..2e31d8c01cbf 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -208,7 +208,7 @@
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
 	};
 
-	wm8978: wm8978 at 1a {
+	wm8978: codec at 1a {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8978";
 		reg = <0x1a>;
-- 
2.1.4
