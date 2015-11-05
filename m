From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 5 Nov 2015 15:40:48 +0800
Subject: [PATCH] ARM: at91/dt: sama5d4: change watchdog compatible
Message-ID: <1446709248-25098-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the watchdog compatible to "atmel,sama5d4-wdt" to support
SAMA5D4 watchdog driver.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 15bbaf6..2193637 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1300,7 +1300,7 @@
 			};
 
 			watchdog at fc068640 {
-				compatible = "atmel,at91sam9260-wdt";
+				compatible = "atmel,sama5d4-wdt";
 				reg = <0xfc068640 0x10>;
 				clocks = <&clk32k>;
 				status = "disabled";
-- 
1.7.9.5
