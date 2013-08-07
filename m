From: larsi@wh2.tu-dresden.de (Lars Poeschel)
Date: Wed,  7 Aug 2013 13:06:32 +0200
Subject: [PATCH] ARM: dts: am33xx: Correct gpio #interrupt-cells property
Message-ID: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lars Poeschel <poeschel@lemonage.de>

Following commit ff5c9059 and therefore other omap platforms using
the gpio-omap driver correct the #interrupt-cells property on am33xx
too. The omap gpio binding documentaion also states that
the #interrupt-cells property should be 2.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..033c5dd 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -102,7 +102,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			reg = <0x44e07000 0x1000>;
 			interrupts = <96>;
 		};
@@ -113,7 +113,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			reg = <0x4804c000 0x1000>;
 			interrupts = <98>;
 		};
@@ -124,7 +124,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			reg = <0x481ac000 0x1000>;
 			interrupts = <32>;
 		};
@@ -135,7 +135,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			reg = <0x481ae000 0x1000>;
 			interrupts = <62>;
 		};
-- 
1.7.10.4
