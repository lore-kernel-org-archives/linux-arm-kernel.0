From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 23 Aug 2012 12:35:57 +0200
Subject: [PATCH] ARM: dts: imx: add imx5x usb entries
Message-ID: <1345718157-7927-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |   28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi |   28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index aba28dc..4ec015f 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -130,6 +130,34 @@
 				};
 			};
 
+			usb at 73f80000 {
+				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
+				reg = <0x73f80000 0x0200>;
+				interrupts = <18>;
+				status = "disabled";
+			};
+
+			usb at 73f80200 {
+				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
+				reg = <0x73f80200 0x0200>;
+				interrupts = <14>;
+				status = "disabled";
+			};
+
+			usb at 73f80400 {
+				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
+				reg = <0x73f80400 0x0200>;
+				interrupts = <16>;
+				status = "disabled";
+			};
+
+			usb at 73f80600 {
+				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
+				reg = <0x73f80600 0x0200>;
+				interrupts = <17>;
+				status = "disabled";
+			};
+
 			gpio1: gpio at 73f84000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f84000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index cd37165..24280a4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -135,6 +135,34 @@
 				};
 			};
 
+			usb at 53f80000 {
+				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
+				reg = <0x53f80000 0x0200>;
+				interrupts = <18>;
+				status = "disabled";
+			};
+
+			usb at 53f80200 {
+				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
+				reg = <0x53f80200 0x0200>;
+				interrupts = <14>;
+				status = "disabled";
+			};
+
+			usb at 53f80400 {
+				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
+				reg = <0x53f80400 0x0200>;
+				interrupts = <16>;
+				status = "disabled";
+			};
+
+			usb at 53f80600 {
+				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
+				reg = <0x53f80600 0x0200>;
+				interrupts = <17>;
+				status = "disabled";
+			};
+
 			gpio1: gpio at 53f84000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f84000 0x4000>;
-- 
1.7.10.4
