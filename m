From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Mar 2014 20:17:20 +0100
Subject: [PATCHv3 3/8] ARM: at91/dt: at91-ariag25: remove useless adc
 properties
In-Reply-To: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394479045-31852-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
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
