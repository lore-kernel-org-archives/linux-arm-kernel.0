From: bonstra@bonstra.fr.eu.org (Hugo Grostabussiat)
Date: Sat, 30 Jul 2016 15:17:42 +0200
Subject: [PATCH] ARM: sun5i: Fix typo in trip point temperature
Message-ID: <6c422122-e83d-84e7-f330-0b747f06d51f@bonstra.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set cpu_alert0 temperature to 85?C instead of 850?C.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi
b/arch/arm/boot/dts/sun5i-a13.dtsi
index 263d46d..2d78eee 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -84,7 +84,7 @@
 			trips {
 				cpu_alert0: cpu_alert0 {
 					/* milliCelsius */
-					temperature = <850000>;
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-- 
2.9.0
