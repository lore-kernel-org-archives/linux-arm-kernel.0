From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:59 +0200
Subject: [PATCH 8/8] ARM: dts: at91: calao: remove leftovers clock definition
In-Reply-To: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465404119-28177-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-qil_a9260.dts    | 9 ---------
 arch/arm/boot/dts/tny_a9260_common.dtsi | 9 ---------
 arch/arm/boot/dts/tny_a9263.dts         | 9 ---------
 arch/arm/boot/dts/usb_a9260_common.dtsi | 9 ---------
 arch/arm/boot/dts/usb_a9263.dts         | 9 ---------
 5 files changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 4f2eebf4a560..7b2745c4bf62 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -20,15 +20,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index ce7138c3af1b..f9dc463b9e48 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -16,15 +16,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 3043296345b7..2f39f85158f7 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -21,15 +21,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 9beea8976584..02b6ff684463 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -8,15 +8,6 @@
 
 / {
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 8cc6edb29694..94c615072f3b 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -21,15 +21,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
-- 
2.8.1
