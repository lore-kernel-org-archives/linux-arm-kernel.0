From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  6 Mar 2017 09:00:40 +0100
Subject: [PATCH 2/2] ARM: dts: fix typo on APQ8060 Dragonboard
Message-ID: <20170306080040.3472-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DTS referred to SDC5 when it meant SDC1.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 39d9e6ddefed..2da1413f5720 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -95,17 +95,17 @@
 					     function = "sdc1";
 				};
 				clk {
-					pins = "gpio167"; /* SDC5 CLK */
+					pins = "gpio167"; /* SDC1 CLK */
 					drive-strength = <16>;
 					bias-disable;
 				};
 				cmd {
-					pins = "gpio168"; /* SDC5 CMD */
+					pins = "gpio168"; /* SDC1 CMD */
 					drive-strength = <10>;
 					bias-pull-up;
 				};
 				data {
-					/* SDC5 D0 to D7 */
+					/* SDC1 D0 to D7 */
 					pins = "gpio159", "gpio160", "gpio161", "gpio162",
 					     "gpio163", "gpio164", "gpio165", "gpio166";
 					drive-strength = <10>;
-- 
2.9.3
