From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 15:00:13 +0100
Subject: [PATCH 3/4] ARM: dts: imx: rename imx5x usb entries as in imx6q.dtsi
In-Reply-To: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352988014-14769-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |   12 ++++++++----
 arch/arm/boot/dts/imx53.dtsi |   12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 75d069f..366b8d3 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -21,6 +21,10 @@
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
 		gpio3 = &gpio4;
+		usb0 = &usbotg;
+		usb1 = &usbhost1;
+		usb2 = &usbhost2;
+		usb3 = &usbhost3;
 	};
 
 	tzic: tz-interrupt-controller at e0000000 {
@@ -130,28 +134,28 @@
 				};
 			};
 
-			usb at 73f80000 {
+			usbotg: usb at 73f80000 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
 				interrupts = <18>;
 				status = "disabled";
 			};
 
-			usb at 73f80200 {
+			usbhost1: usb at 73f80200 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80200 0x0200>;
 				interrupts = <14>;
 				status = "disabled";
 			};
 
-			usb at 73f80400 {
+			usbhost2: usb at 73f80400 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80400 0x0200>;
 				interrupts = <16>;
 				status = "disabled";
 			};
 
-			usb at 73f80600 {
+			usbhost3: usb at 73f80600 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80600 0x0200>;
 				interrupts = <17>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 76ebb1a..2faa193 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -26,6 +26,10 @@
 		gpio4 = &gpio5;
 		gpio5 = &gpio6;
 		gpio6 = &gpio7;
+		usb0 = &usbotg;
+		usb1 = &usbhost1;
+		usb2 = &usbhost2;
+		usb3 = &usbhost3;
 	};
 
 	tzic: tz-interrupt-controller at 0fffc000 {
@@ -135,28 +139,28 @@
 				};
 			};
 
-			usb at 53f80000 {
+			usbotg: usb at 53f80000 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
 				interrupts = <18>;
 				status = "disabled";
 			};
 
-			usb at 53f80200 {
+			usbhost1: usb at 53f80200 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80200 0x0200>;
 				interrupts = <14>;
 				status = "disabled";
 			};
 
-			usb at 53f80400 {
+			usbhost2: usb at 53f80400 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80400 0x0200>;
 				interrupts = <16>;
 				status = "disabled";
 			};
 
-			usb at 53f80600 {
+			usbhost3: usb at 53f80600 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80600 0x0200>;
 				interrupts = <17>;
-- 
1.7.10.4
