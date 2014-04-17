From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Apr 2014 09:42:40 -0300
Subject: [PATCH 1/2] ARM: dts: imx27-pdk: Add NAND support
Message-ID: <1397738561-3335-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-pdk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 971961f..c629a8c 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -84,6 +84,12 @@
 	status = "okay";
 };
 
+&nfc {
+	status = "okay";
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+};
+
 &uart1 {
 	fsl,uart-has-rtscts;
 	pinctrl-names = "default";
-- 
1.8.3.2
