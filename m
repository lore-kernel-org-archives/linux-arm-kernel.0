From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:34 +0900
Subject: [PATCH 04/30] ARM: dts: r8a7790: Correct unit names for cpu nodes
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <1eed15e411527e058ca6c4b4f5b691aacb608a5e.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make the unit names for the cpu nodes match their reg properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 83cf23cd26bb..3b9e98be2f7b 100644
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
2.1.4
