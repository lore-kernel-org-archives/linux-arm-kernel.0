From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:42 +0900
Subject: [PATCH 13/31] ARM: shmobile: r8a7791 dtsi: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <6c63e07dcc2e941288d18e3fe9b448265f9ca9d0.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

rcar_sound -> sound

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d2c41ad701cc..30e1e13a228f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1494,7 +1494,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound at ec500000 {
+	rcar_sound: sound at ec500000 {
 		/*
 		 * #sound-dai-cells is required
 		 *
-- 
2.1.4
