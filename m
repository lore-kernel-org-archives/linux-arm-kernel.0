From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Mar 2014 20:17:25 +0100
Subject: [PATCHv3 8/8] ARM: at91/dt: at91-cosino: remove useless adc properties
In-Reply-To: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394479045-31852-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394479045-31852-9-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the properties that are not used anymore by the at91_adc driver.

Cc: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-cosino.dtsi         | 1 -
 arch/arm/boot/dts/at91-cosino_mega2560.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-cosino.dtsi b/arch/arm/boot/dts/at91-cosino.dtsi
index 2093c4d7cd6a..df4b78695695 100644
--- a/arch/arm/boot/dts/at91-cosino.dtsi
+++ b/arch/arm/boot/dts/at91-cosino.dtsi
@@ -64,7 +64,6 @@
 			};
 
 			adc0: adc at f804c000 {
-				atmel,adc-clock-rate = <1000000>;
 				atmel,adc-ts-wires = <4>;
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/at91-cosino_mega2560.dts b/arch/arm/boot/dts/at91-cosino_mega2560.dts
index f9415dd11f17..a542d5837a17 100644
--- a/arch/arm/boot/dts/at91-cosino_mega2560.dts
+++ b/arch/arm/boot/dts/at91-cosino_mega2560.dts
@@ -27,7 +27,6 @@
 			};
 
 			adc0: adc at f804c000 {
-				atmel,adc-clock-rate = <1000000>;
 				atmel,adc-ts-wires = <4>;
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "okay";
-- 
1.8.3.2
