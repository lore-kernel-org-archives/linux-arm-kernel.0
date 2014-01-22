From: silvio.fricke@gmail.com (Silvio F)
Date: Wed, 22 Jan 2014 20:39:26 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: edmqmx6: fix wrong usbotg pingroup
In-Reply-To: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
References: <1390419567-2643-1-git-send-email-silvio.fricke@gmail.com>
Message-ID: <1390419567-2643-2-git-send-email-silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio F <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index b8a1ff4..6706d1b 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -266,7 +266,7 @@
 		};
 
 		pinctrl_usbotg: usbotggrp {
-			fsl,pins = <MX6QDL_USBOTG_PINGRP1>;
+			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
 		};
 
 		pinctrl_usdhc3: usdhc3grp {
-- 
1.8.5.2
