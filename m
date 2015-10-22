From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:19:24 +0200
Subject: [PATCH 3/4] arm: dts: add dm816x pwm property to timers
Message-ID: <5628AA1C.4090305@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds ti,timer-pwm property to timers 4 to 7 to permit usage of their
PWM output fonctionnality via the dmtimer driver.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index eee636d..51ad4a9 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -323,6 +323,7 @@
 			reg = <0x48044000 0x2000>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			ti,timer-pwm;
 		};

 		timer5: timer at 48046000 {
@@ -330,6 +331,7 @@
 			reg = <0x48046000 0x2000>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			ti,timer-pwm;
 		};

 		timer6: timer at 48048000 {
@@ -337,6 +339,7 @@
 			reg = <0x48048000 0x2000>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			ti,timer-pwm;
 		};

 		timer7: timer at 4804a000 {
@@ -344,6 +347,7 @@
 			reg = <0x4804a000 0x2000>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			ti,timer-pwm;
 		};

 		uart1: uart at 48020000 {
-- 
1.9.1
