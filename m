From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 11 Apr 2013 12:13:17 +0200
Subject: [PATCH 4/4] ARM: dts: imx: imx53-qsb.dts: enable usbotg and usbh1
In-Reply-To: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1365675197-9687-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 05cc562..953b2d4 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -83,6 +83,14 @@
 	};
 };
 
+&usbotg {
+       status = "okay";
+};
+
+&usbh1 {
+       status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1_1>;
-- 
1.8.2.rc2
