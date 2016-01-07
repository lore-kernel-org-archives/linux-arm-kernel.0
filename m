From: tharvey@gateworks.com (Tim Harvey)
Date: Thu,  7 Jan 2016 09:57:46 -0800
Subject: [PATCH] ARM: dts: imx: ventana: fix PWM pinmux for Ventana boards
Message-ID: <1452189466-22439-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some invalid pwm pinmux configurations.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index fb0abd6..2e2cd5c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -320,13 +320,13 @@
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
 			>;
 		};
 
 		pinctrl_pwm4: pwm4grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT2__PWM4_OUT		0x1b0b1
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 7fc45a4..7172e11 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -473,7 +473,7 @@
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c37f89d..8097d6a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -462,7 +462,7 @@
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index cca39f1..f27f184 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -262,7 +262,7 @@
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
 			>;
 		};
 
-- 
1.9.1
