From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 19:53:17 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: enable RTC wakeup
Message-ID: <20170202185317.21800-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d2 Xplained can wake up with its RTC. Enable that feature.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d5fdac..da47fa19f474 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -244,6 +244,7 @@
 
 			shdwc at f8048010 {
 				atmel,shdwc-debouncer = <976>;
+				atmel,wakeup-rtc-timer;
 
 				input at 0 {
 					reg = <0>;
-- 
2.11.0
