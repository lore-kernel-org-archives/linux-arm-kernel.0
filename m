From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed,  5 Dec 2012 09:34:27 +0800
Subject: [v2 PATCH 8/8] ARM: dts: add the watchdog nodes for at91sam9g25ek
 boards
In-Reply-To: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1354671267-19277-9-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on the at91sam9g25ek boards

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/at91sam9g25ek.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 877c08f..2f03edc 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -44,6 +44,10 @@
 			i2c2: i2c at f8018000 {
 				status = "okay";
 			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00600000 {
-- 
1.7.9.5
