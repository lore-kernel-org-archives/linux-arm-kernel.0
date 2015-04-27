From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:29 +0200
Subject: [PATCH 05/10] ARM: shmobile: r8a7791 dtsi: Use generic names for
 device nodes
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430139334-15272-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rcar_sound -> sound

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3e9f824797e75aed..9492c961ad4ee12d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1485,7 +1485,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound at ec500000 {
+	rcar_sound: sound at ec500000 {
 		/*
 		 * #sound-dai-cells is required
 		 *
-- 
1.9.1
