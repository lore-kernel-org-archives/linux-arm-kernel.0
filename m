From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:41 +0900
Subject: [PATCH 12/31] ARM: shmobile: r8a7790 dtsi: Use generic names for
 device nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <b694e3807b5b12273ba057e8cfcf82c2331606e0.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

rcar_sound -> sound

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 22e73906ec88..c9055e39b8bb 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1451,7 +1451,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound at ec500000 {
+	rcar_sound: sound at ec500000 {
 		/*
 		 * #sound-dai-cells is required
 		 *
-- 
2.1.4
