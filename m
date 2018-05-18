From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:40 +0200
Subject: [PATCH 078/102] arm64: dts: renesas: r8a7796: Correct whitespace
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <e4d9242a30dce2ec01e8a321237c4b8d08c12c7b.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add missing spaces after commas.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 3fbd86590fb0..6ffab2da07cb 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -143,7 +143,7 @@
 		};
 
 		a57_1: cpu at 1 {
-			compatible = "arm,cortex-a57","arm,armv8";
+			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7796_PD_CA57_CPU1>;
@@ -166,7 +166,7 @@
 		};
 
 		a53_1: cpu at 101 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x101>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7796_PD_CA53_CPU1>;
@@ -177,7 +177,7 @@
 		};
 
 		a53_2: cpu at 102 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x102>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7796_PD_CA53_CPU2>;
@@ -188,7 +188,7 @@
 		};
 
 		a53_3: cpu at 103 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x103>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7796_PD_CA53_CPU3>;
-- 
2.11.0
