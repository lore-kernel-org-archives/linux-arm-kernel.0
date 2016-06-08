From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:57 +0200
Subject: [PATCH 6/8] ARM: dts: at91: mpa1600: remove leftovers clock definition
In-Reply-To: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465404119-28177-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Cc: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/mpa1600.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index f0f5e1098928..30e66e57870c 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -17,15 +17,6 @@
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
