From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 27 Apr 2015 14:55:32 +0200
Subject: [PATCH 08/10] ARM: shmobile: armadillo800eva dts: Use generic names
 for device nodes
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430139334-15272-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

wm8978 -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 9bd0cb439f448d03..2e31d8c01cbf6a74 100644
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
1.9.1
