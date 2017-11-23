From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 23 Nov 2017 13:00:12 -0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Pass the DDC I2C bus
Message-ID: <1511449213-13855-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx6qdl-sabreauto the HDMI DDC bus is connected to I2C2, so
pass the 'ddc-i2c-bus' property accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 4fa2fac..de9bf47 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -235,6 +235,7 @@
 };
 
 &hdmi {
+	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
 };
 
-- 
2.7.4
