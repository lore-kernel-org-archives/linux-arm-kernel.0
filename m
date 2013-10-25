From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 25 Oct 2013 14:02:23 +0800
Subject: [PATCH v3 5/5] ARM: dts: imx28: changing usb compatible string as
 only "fsl, imx28-usb"
In-Reply-To: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382680943-9258-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to imx28 usb has special write request, it is not compatible
with other imx27 sytle usb controllers.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7363fde..6cd2607 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1041,7 +1041,7 @@
 		ranges;
 
 		usb0: usb at 80080000 {
-			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
+			compatible = "fsl,imx28-usb";
 			reg = <0x80080000 0x10000>;
 			interrupts = <93>;
 			clocks = <&clks 60>;
@@ -1050,7 +1050,7 @@
 		};
 
 		usb1: usb at 80090000 {
-			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
+			compatible = "fsl,imx28-usb";
 			reg = <0x80090000 0x10000>;
 			interrupts = <92>;
 			clocks = <&clks 61>;
-- 
1.7.1
