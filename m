From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:22 +0100
Subject: [PATCH 25/47] ARM: dts: r8a7791: consistently use single space before
 =
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <c57c1b7ce8c6743ca745a577e7ac6b81a59a2479.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use a single space before a =.

This patch fixes instances where a tab is used instead.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index dc659351472f..f11dab71b03a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1703,16 +1703,16 @@
 
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
-			polling-delay-passive	= <0>;
-			polling-delay		= <0>;
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
 
 			thermal-sensors = <&thermal>;
 
 			trips {
 				cpu-crit {
-					temperature	= <95000>;
-					hysteresis	= <0>;
-					type		= "critical";
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "critical";
 				};
 			};
 			cooling-maps {
-- 
2.11.0
