From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:54 +0900
Subject: [PATCH 25/31] ARM: shmobile: lager dts: Use generic names for device
 nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <d22b16876b62b4ffe2b4e31fb7a6e1af1a45fa25.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

sound-codec -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a6c793de8d80..b6cffcedd116 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -525,7 +525,7 @@
 
 	clock-frequency = <100000>;
 
-	ak4643: sound-codec at 12 {
+	ak4643: codec at 12 {
 		compatible = "asahi-kasei,ak4643";
 		#sound-dai-cells = <0>;
 		reg = <0x12>;
-- 
2.1.4
