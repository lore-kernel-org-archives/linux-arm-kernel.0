From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:58 +0200
Subject: [PATCH 7/8] ARM: dts: at91: pm9g45: remove leftovers clock definition
In-Reply-To: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465404119-28177-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/pm9g45.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/pm9g45.dts
index 66afcff67fde..0abd7bf17568 100644
--- a/arch/arm/boot/dts/pm9g45.dts
+++ b/arch/arm/boot/dts/pm9g45.dts
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
