From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:29:23 +0200
Subject: [PATCH 3/3] ARM: shmobile: koelsch dts: Use generic names for device
 nodes
In-Reply-To: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
References: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430216963-8161-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sound-codec -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74c3212f1f11e47e..f790c2466939c5ee 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -522,7 +522,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
-	ak4643: sound-codec at 12 {
+	ak4643: codec at 12 {
 		compatible = "asahi-kasei,ak4643";
 		#sound-dai-cells = <0>;
 		reg = <0x12>;
-- 
1.9.1
