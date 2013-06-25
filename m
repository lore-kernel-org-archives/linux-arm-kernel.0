From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Jun 2013 15:51:58 +0200
Subject: [PATCH 14/16] ARM: dts: i.MX51: move kpp pinmux entry
In-Reply-To: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1372168320-22605-15-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For keeping the alphabetical order in the pinmux nodes.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index f64c87e..7eb026e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -486,6 +486,21 @@
 					};
 				};
 
+				kpp {
+					pinctrl_kpp_1: kppgrp-1 {
+						fsl,pins = <
+							MX51_PAD_KEY_ROW0__KEY_ROW0 0xe0
+							MX51_PAD_KEY_ROW1__KEY_ROW1 0xe0
+							MX51_PAD_KEY_ROW2__KEY_ROW2 0xe0
+							MX51_PAD_KEY_ROW3__KEY_ROW3 0xe0
+							MX51_PAD_KEY_COL0__KEY_COL0 0xe8
+							MX51_PAD_KEY_COL1__KEY_COL1 0xe8
+							MX51_PAD_KEY_COL2__KEY_COL2 0xe8
+							MX51_PAD_KEY_COL3__KEY_COL3 0xe8
+						>;
+					};
+				};
+
 				pata {
 					pinctrl_pata_1: patagrp-1 {
 						fsl,pins = <
@@ -559,21 +574,6 @@
 						>;
 					};
 				};
-
-				kpp {
-					pinctrl_kpp_1: kppgrp-1 {
-						fsl,pins = <
-							MX51_PAD_KEY_ROW0__KEY_ROW0 0xe0
-							MX51_PAD_KEY_ROW1__KEY_ROW1 0xe0
-							MX51_PAD_KEY_ROW2__KEY_ROW2 0xe0
-							MX51_PAD_KEY_ROW3__KEY_ROW3 0xe0
-							MX51_PAD_KEY_COL0__KEY_COL0 0xe8
-							MX51_PAD_KEY_COL1__KEY_COL1 0xe8
-							MX51_PAD_KEY_COL2__KEY_COL2 0xe8
-							MX51_PAD_KEY_COL3__KEY_COL3 0xe8
-						>;
-					};
-				};
 			};
 
 			pwm1: pwm at 73fb4000 {
-- 
1.8.3.1
