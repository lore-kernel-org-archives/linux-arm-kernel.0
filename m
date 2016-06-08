From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:54 +0200
Subject: [PATCH 3/8] ARM: dts: at91: at91-cosino: remove leftovers clock
 definition
In-Reply-To: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465404119-28177-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Cc: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-cosino.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index b6ea3f4a7206..02d8ef43de3a 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -26,15 +26,6 @@
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
