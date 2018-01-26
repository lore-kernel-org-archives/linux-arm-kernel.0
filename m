From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Jan 2018 10:36:35 +0100
Subject: [PATCH 3/3] ARM: dts: r8a7793: consistently use single space before =
In-Reply-To: <20180126093635.16945-1-horms+renesas@verge.net.au>
References: <20180126093635.16945-1-horms+renesas@verge.net.au>
Message-ID: <20180126093635.16945-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently use a single space before a =.

This patch fixes instances where a tab is used instead.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index aa7d7792fb13..f9c5a557107d 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1362,16 +1362,16 @@
 
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
