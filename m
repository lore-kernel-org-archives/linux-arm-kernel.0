From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed,  3 Oct 2012 17:48:06 +0200
Subject: [PATCH v8 3/3] ARM: at91/dts: evk-pro3: enable watchdog
In-Reply-To: <1349279286-11261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349279286-11261-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1349279286-11261-4-git-send-email-fabio.porcedda@gmail.com>
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
1.7.11.3
