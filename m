From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 17:24:51 +0100
Subject: [PATCH] ARM: at91/dt: at91sam9x5cm: enable RTC
Message-ID: <1426782291-22596-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable RTC for all the at91sam9x5 CPU Modules: this will enable it for all the
EK boards.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5cm.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 229d6c24a9c4..26112ebd15fc 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -42,6 +42,10 @@
 					};
 				};
 			};
+
+			rtc at fffffeb0 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
2.1.3
