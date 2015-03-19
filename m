From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 17:44:00 +0100
Subject: [PATCH] ARM: at91/dt: at91sam9n12ek: enable RTC
Message-ID: <1426783440-15021-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 6123109f14ff..6e067c8a3502 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -137,6 +137,10 @@
 			watchdog at fffffe40 {
 				status = "okay";
 			};
+
+			rtc at fffffeb0 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
2.1.3
