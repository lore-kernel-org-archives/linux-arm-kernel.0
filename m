From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:52 +0200
Subject: [PATCH 1/8] ARM: dts: at91: animeo_ip: remove leftovers clock
 definition
Message-ID: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/animeo_ip.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 0962f2fa3f6e..419dd3981edf 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -32,15 +32,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <18432000>;
-		};
-
 		slow_xtal {
 			clock-frequency = <32768>;
 		};
-- 
2.8.1
