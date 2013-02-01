From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri,  1 Feb 2013 15:06:26 +0800
Subject: [PATCH v4 8/8] ARM: dts: add the watchdog nodes for at91sam9g25ek and
 at91sam9m10g45ek boards
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1359702386-21284-9-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on the at91sam9g25ek and at91sam9m10g45ek boards

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    4 ++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi    |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 20c3191..0832c7a 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -59,6 +59,10 @@
 				status = "okay";
 			};
 
+			watchdog at fffffd40 {
+				status = "okay";
+			};
+
 			mmc0: mmc at fff80000 {
 				pinctrl-0 = <
 					&pinctrl_board_mmc0
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 8a7cf1d..afddf75 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -69,6 +69,10 @@
 				status = "okay";
 			};
 
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+
 			pinctrl@fffff400 {
 				mmc0 {
 					pinctrl_board_mmc0: mmc0-board {
-- 
1.7.9.5
