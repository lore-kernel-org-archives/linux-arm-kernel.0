From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 18 May 2015 12:19:18 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4 xplained: add spi1 on j14 connector
Message-ID: <1431944358-29179-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index c740e1a2a3a5..5e32acc6082e 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -122,6 +122,11 @@
 				status = "okay";
 			};
 
+			spi1: spi at fc018000 {
+				cs-gpios = <&pioB 21 0>;
+				status = "okay";
+			};
+
 			adc0: adc at fc034000 {
 				atmel,adc-vref = <3300>;
 				status = "okay";
-- 
2.1.3
