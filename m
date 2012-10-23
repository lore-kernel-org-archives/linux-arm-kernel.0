From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue, 23 Oct 2012 12:00:16 +0200
Subject: [PATCH] ARM: at91: dt: evk-pro3: enable uart0 and uart2
Message-ID: <1350986416-16246-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/evk-pro3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index ce959ee..96e50f5 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -22,6 +22,14 @@
 				status = "okay";
 			};
 
+			usart0: serial at fffb0000 {
+				status = "okay";
+			};
+
+			usart2: serial at fffb8000 {
+				status = "okay";
+			};
+
 			usb1: gadget at fffa4000 {
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
-- 
1.7.11.3
