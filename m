From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 23 Feb 2016 14:10:04 +0100
Subject: [PATCH] ARM: dts: stm32f429: Fix clocks referenced by GPIO banks
Message-ID: <1456233004-17848-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the clocks referenced by the GPIO banks were not the good ones.

Reported-by: Bruno Herrera <bruherrera@gmail.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35b2ab1..598362e 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -182,7 +182,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x0 0x400>;
-				clocks = <&rcc 0 256>;
+				clocks = <&rcc 0 0>;
 				st,bank-name = "GPIOA";
 			};
 
@@ -190,7 +190,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x400 0x400>;
-				clocks = <&rcc 0 257>;
+				clocks = <&rcc 0 1>;
 				st,bank-name = "GPIOB";
 			};
 
@@ -198,7 +198,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x800 0x400>;
-				clocks = <&rcc 0 258>;
+				clocks = <&rcc 0 2>;
 				st,bank-name = "GPIOC";
 			};
 
@@ -206,7 +206,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0xc00 0x400>;
-				clocks = <&rcc 0 259>;
+				clocks = <&rcc 0 3>;
 				st,bank-name = "GPIOD";
 			};
 
@@ -214,7 +214,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1000 0x400>;
-				clocks = <&rcc 0 260>;
+				clocks = <&rcc 0 4>;
 				st,bank-name = "GPIOE";
 			};
 
@@ -222,7 +222,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1400 0x400>;
-				clocks = <&rcc 0 261>;
+				clocks = <&rcc 0 5>;
 				st,bank-name = "GPIOF";
 			};
 
@@ -230,7 +230,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1800 0x400>;
-				clocks = <&rcc 0 262>;
+				clocks = <&rcc 0 6>;
 				st,bank-name = "GPIOG";
 			};
 
@@ -238,7 +238,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x1c00 0x400>;
-				clocks = <&rcc 0 263>;
+				clocks = <&rcc 0 7>;
 				st,bank-name = "GPIOH";
 			};
 
@@ -246,7 +246,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2000 0x400>;
-				clocks = <&rcc 0 264>;
+				clocks = <&rcc 0 8>;
 				st,bank-name = "GPIOI";
 			};
 
@@ -254,7 +254,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2400 0x400>;
-				clocks = <&rcc 0 265>;
+				clocks = <&rcc 0 9>;
 				st,bank-name = "GPIOJ";
 			};
 
@@ -262,7 +262,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 				reg = <0x2800 0x400>;
-				clocks = <&rcc 0 266>;
+				clocks = <&rcc 0 10>;
 				st,bank-name = "GPIOK";
 			};
 
-- 
1.9.1
