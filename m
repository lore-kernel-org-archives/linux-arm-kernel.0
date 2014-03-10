From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 17:54:39 -0300
Subject: [PATCH 1/7] ARM: dts: mx25: Fix compatible string for generic USB PHY
Message-ID: <1394484885-21262-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt, the
correct compatible string for the generic USB PHY is 'usb-nop-xceiv'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 77bb743..6088059 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -483,12 +483,12 @@
 			};
 
 			usbphy1: usbphy at 1 {
-				compatible = "nop-usbphy";
+				compatible = "usb-nop-xceiv";
 				status = "disabled";
 			};
 
 			usbphy2: usbphy at 2 {
-				compatible = "nop-usbphy";
+				compatible = "usb-nop-xceiv";
 				status = "disabled";
 			};
 
-- 
1.8.1.2
