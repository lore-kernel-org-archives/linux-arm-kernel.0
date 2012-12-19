From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 19 Dec 2012 19:38:57 +0100
Subject: [PATCH 1/1] ARM: at91: Animeo IP: add adc support
Message-ID: <1355942337-26892-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/animeo_ip.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index be170ec..0d1ccc4 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -79,6 +79,13 @@
 				};
 			};
 
+			adc0: adc at fffe0000 {
+				atmel,adc-channels-used = <0x3>;
+				atmel,adc-sleep-mode;
+				atmel,adc-sample-hold-time = <2>;
+				status = "okay";
+			};
+
 			watchdog at fffffd40 {
 				status = "okay";
 			};
-- 
1.7.10.4
