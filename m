From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Apr 2014 16:29:24 +0200
Subject: [PATCH 1/4] ARM: dts: imx6: edmqmx6: Fix usbotg id pin
Message-ID: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index a63bbb3d46bb..39ffa766384f 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -293,7 +293,7 @@
 
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
 			>;
 		};
 
-- 
1.9.1
