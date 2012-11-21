From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 16:28:13 +0100
Subject: [PATCH 1/1] ARM: at91: Animeo IP: enable watchdog support
Message-ID: <1353511693-23000-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre at atmel.com
Cc: Sylvain FARGIER <sylvain.fargier@somfy.com>
---
 arch/arm/boot/dts/animeo_ip.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 2746dca..9f1f1a0 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -77,6 +77,10 @@
 					bus-width = <4>;
 				};
 			};
+
+			watchdog at fffffd40 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
