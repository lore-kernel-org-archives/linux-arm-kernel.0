From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 13 May 2016 09:38:33 +0200
Subject: [PATCH] ARM: dts: r8a7790: Correct unit names for cpu nodes
Message-ID: <1463125113-28885-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the unit names for the cpu nodes match their reg properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 83cf23cd26bb51e6..3b9e98be2f7b3122 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -92,7 +92,7 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		cpu4: cpu at 4 {
+		cpu4: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
@@ -101,7 +101,7 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		cpu5: cpu at 5 {
+		cpu5: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
@@ -110,7 +110,7 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		cpu6: cpu at 6 {
+		cpu6: cpu at 102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
@@ -119,7 +119,7 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
-		cpu7: cpu at 7 {
+		cpu7: cpu at 103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
-- 
1.9.1
