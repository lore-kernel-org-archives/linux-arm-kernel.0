From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  7 Apr 2013 20:13:45 -0300
Subject: [PATCH] ARM: dts: imx6dl-wandboard: Add USB Host support
Message-ID: <1365376426-13919-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add USB Host1 port support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6dl-wandboard.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index d3ea90a..735911b 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -38,3 +38,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3_2>;
 	status = "okay";
 };
+
+&usbh1 {
+	status = "okay";
+};
-- 
1.7.9.5
