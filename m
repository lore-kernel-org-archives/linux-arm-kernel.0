From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 19:12:23 +0100
Subject: [PATCH v3 3/6] ARM: at91/dt: at91rm9200ek: enable RTC
In-Reply-To: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421172746-18727-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the RTC on the at91rm9200ek.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index 43eb779dd6f6..2a5d21247d7e 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -77,6 +77,10 @@
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			rtc: rtc at fffffe00 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00300000 {
-- 
2.1.0
