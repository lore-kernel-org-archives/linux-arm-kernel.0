From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  8 Jun 2016 18:41:53 +0200
Subject: [PATCH 2/8] ARM: dts: at91: at91-ariag25: remove leftovers clock
 definition
In-Reply-To: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465404119-28177-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465404119-28177-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks group properties and the clock at 0 node have been obsolete for two
years, remove them.

Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-ariag25.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index e9ced30159a7..f16a9b85a450 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -34,15 +34,6 @@
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
