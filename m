From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  5 Jun 2016 13:49:27 +0000
Subject: [PATCH 1/4] ARM: dts: mxs: add missing reg properties for GPIO banks
Message-ID: <1465134567-13421-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing reg properties for the MXS GPIO banks
in order to fix the dtc warnings.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |    3 +++
 arch/arm/boot/dts/imx28.dtsi |    5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 302d116..1bfa533 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -111,6 +111,7 @@
 
 				gpio0: gpio at 0 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					reg = <0>;
 					interrupts = <16>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -120,6 +121,7 @@
 
 				gpio1: gpio at 1 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					reg = <1>;
 					interrupts = <17>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -129,6 +131,7 @@
 
 				gpio2: gpio at 2 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
+					reg = <2>;
 					interrupts = <18>;
 					gpio-controller;
 					#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 74aa151..0ad893b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -165,6 +165,7 @@
 
 				gpio0: gpio at 0 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					reg = <0>;
 					interrupts = <127>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -174,6 +175,7 @@
 
 				gpio1: gpio at 1 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					reg = <1>;
 					interrupts = <126>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -183,6 +185,7 @@
 
 				gpio2: gpio at 2 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					reg = <2>;
 					interrupts = <125>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -192,6 +195,7 @@
 
 				gpio3: gpio at 3 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					reg = <3>;
 					interrupts = <124>;
 					gpio-controller;
 					#gpio-cells = <2>;
@@ -201,6 +205,7 @@
 
 				gpio4: gpio at 4 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
+					reg = <4>;
 					interrupts = <123>;
 					gpio-controller;
 					#gpio-cells = <2>;
-- 
1.7.9.5
