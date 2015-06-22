From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 22 Jun 2015 09:45:47 +0200
Subject: [PATCH 1/2] ARM: at91/dt: sama5d4: fix external trigger property
Message-ID: <1434959149-4067-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property is actually atmel,adc-use-external-triggers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 6b1bb58f9c0b..ca1e52989a29 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1092,7 +1092,7 @@
 				clock-names = "adc_clk", "adc_op_clk";
 				atmel,adc-channels-used = <0x01f>;
 				atmel,adc-startup-time = <40>;
-				atmel,adc-use-external;
+				atmel,adc-use-external-triggers;
 				atmel,adc-vref = <3000>;
 				atmel,adc-res = <8 10>;
 				atmel,adc-sample-hold-time = <11>;
-- 
2.1.4
