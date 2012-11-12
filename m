From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Mon, 12 Nov 2012 09:37:27 +0100
Subject: [PATCH v9 RESEND 3/3] ARM: at91/dts: evk-pro3: enable watchdog
In-Reply-To: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com>
References: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1352709447-8306-4-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on evk-pro3.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/evk-pro3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index b7354e6..ce959ee 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -26,6 +26,10 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00500000 {
-- 
1.8.0
