From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 28 Sep 2017 11:25:57 -0300
Subject: [PATCH] ARM: dts: imx25-pdk: Add touchscreen support
Message-ID: <1506608757-8604-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the built-in touchscreen controller present on MX25.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index c526928..5ef2fed 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -295,6 +295,14 @@
 	status = "okay";
 };
 
+&tsc {
+	status = "okay";
+};
+
+&tscadc {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.7.4
