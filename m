From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 19 Feb 2018 09:56:44 +0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-hummingboard: fix USBOTG-ID pin
Message-ID: <535f327ebffa93ee780381e6c9f9f39b7c6d1a26.1519027005.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Nettleton <jon@solid-run.com>

Fix the USBOTG-ID pin to the correct definition.  The top
USB port stays in device-mode without this change.

Signed-off-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 92583238ca4a..e59b1aeba1d7 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -242,7 +242,7 @@
 			 * Similar to pinctrl_usbotg_2, but we want it
 			 * pulled down for a fixed host connection.
 			 */
-			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+			fsl,pins = <MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x13059>;
 		};
 
 		pinctrl_hummingboard_usbotg_vbus: hummingboard-usbotg-vbus {
-- 
2.16.1
