From: bonstra@bonstra.fr.eu.org (Hugo Grostabussiat)
Date: Tue, 16 Aug 2016 20:34:07 +0200
Subject: [RESEND][PATCH] ARM: sun5i: Fix typo in trip point temperature
Message-ID: <d936e96e-7c2f-0607-0b04-3adfcdcadf98@bonstra.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set cpu_alert0 temperature to 85?C instead of 850?C.

Fixes: 32a5d2d170cc ("ARM: dts: sun5i: Add cpu thermal zones to dtsi")
Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
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
2.9.3
