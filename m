From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  5 Apr 2013 14:33:02 +0200
Subject: [PATCH] ARM: dts: cfa10036: Add touchscreen support to the CFA-10049
Message-ID: <1365165182-29502-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index b9dad4e..f16c1e2 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -192,6 +192,11 @@
 			usbphy1: usbphy at 8007e000 {
 				status = "okay";
 			};
+
+			lradc at 80050000 {
+				status = "okay";
+				fsl,lradc-touchscreen-wires = <4>;
+			};
 		};
 	};
 
-- 
1.7.10.4
