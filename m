From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Feb 2014 18:01:10 +0100
Subject: [PATCH 3/7] ARM: at91/dt: at91-ariag25: remove useless adc properties
In-Reply-To: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1393434074-15600-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Also, stop using unit-addresses for the triggers as suggested by Mark
Rutland in
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234184.html

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-ariag25.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index cce45f5177f9..55ab6180e350 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -129,7 +129,6 @@
 			adc0: adc at f804c000 {
 				status = "okay";
 				atmel,adc-channels-used = <0xf>;
-				atmel,adc-num-channels = <4>;
 			};
 
 			dbgu: serial at fffff200 {
-- 
1.8.3.2
