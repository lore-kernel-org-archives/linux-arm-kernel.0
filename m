From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:53 +0900
Subject: [PATCH 24/31] ARM: shmobile: bockw dts: Use generic names for device
 nodes
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <61ffb5ca6c8e5246c7b257a733c33b94b19de3da.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

sound-codec -> codec

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 7ebc4a4f4608..dfbb12e4fef4 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -85,7 +85,7 @@
 &i2c0 {
 	status = "okay";
 
-	ak4643: sound-codec at 12 {
+	ak4643: codec at 12 {
 		compatible = "asahi-kasei,ak4643";
 		#sound-dai-cells = <0>;
 		reg = <0x12>;
-- 
2.1.4
