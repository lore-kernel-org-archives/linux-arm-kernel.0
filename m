From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 29 May 2017 07:51:19 +0300
Subject: [PATCH] ARM: dts: sama5d2_xplained: remove wrong memory node
Message-ID: <04c9a65854a644958ebabf10d97359021b947cb4.1496033479.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size field of the memory node is wrong. Rely on the default value in
sama5d2.dtsi that happens to be correct for the SAMA5D2 Xplained board.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0bef9e0b89c6..14437d7697e6 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -56,10 +56,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
-		reg = <0x20000000 0x80000>;
-	};
-
 	clocks {
 		slow_xtal {
 			clock-frequency = <32768>;
-- 
2.11.0
