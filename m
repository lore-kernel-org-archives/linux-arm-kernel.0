From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 15:00:14 +0100
Subject: [PATCH 4/4] ARM: dts: imx: add imx5x phy-mode entries
In-Reply-To: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352988014-14769-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |    2 ++
 arch/arm/boot/dts/imx53.dtsi |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 366b8d3..ffc6bc8 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -145,6 +145,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80200 0x0200>;
 				interrupts = <14>;
+				phy-mode = "utmiw";
 				status = "disabled";
 			};
 
@@ -152,6 +153,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80400 0x0200>;
 				interrupts = <16>;
+				phy-mode = "utmi";
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 2faa193..1da8e12 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -143,6 +143,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
 				interrupts = <18>;
+				phy-mode = "utmiw";
 				status = "disabled";
 			};
 
@@ -150,6 +151,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80200 0x0200>;
 				interrupts = <14>;
+				phy-mode = "utmi";
 				status = "disabled";
 			};
 
-- 
1.7.10.4
