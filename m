From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 11 Apr 2013 12:13:15 +0200
Subject: [PATCH 2/4] ARM: dts: imx: add imx5x usb clock DT lookups
In-Reply-To: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1365675197-9687-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 5 +++++
 arch/arm/boot/dts/imx53.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 2316472..01fe241 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -157,6 +157,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
 				interrupts = <18>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -165,6 +166,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80200 0x0200>;
 				interrupts = <14>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
@@ -173,6 +175,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80400 0x0200>;
 				interrupts = <16>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
@@ -181,6 +184,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80600 0x0200>;
 				interrupts = <17>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
@@ -189,6 +193,7 @@
 				#index-cells = <1>;
 				compatible = "fsl,imx51-usbmisc";
 				reg = <0x73f80800 0x200>;
+				clocks = <&clks 108>;
 			};
 
 			gpio1: gpio at 73f84000 {
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c00a100..9a1595f 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -163,6 +163,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
 				interrupts = <18>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
@@ -171,6 +172,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80200 0x0200>;
 				interrupts = <14>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
@@ -179,6 +181,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80400 0x0200>;
 				interrupts = <16>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
@@ -187,6 +190,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80600 0x0200>;
 				interrupts = <17>;
+				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
@@ -195,6 +199,7 @@
 				#index-cells = <1>;
 				compatible = "fsl,imx53-usbmisc";
 				reg = <0x53f80800 0x200>;
+				clocks = <&clks 108>;
 			};
 
 			gpio1: gpio at 53f84000 {
-- 
1.8.2.rc2
