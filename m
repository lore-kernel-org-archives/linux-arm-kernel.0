From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jul 2013 09:49:30 -0300
Subject: [PATCH v3 1/4] ARM: dts: imx6qdl.dtsi: Add usdhc1 pin groups
Message-ID: <1373633373-3352-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- None. Newly introduced in this series

 arch/arm/boot/dts/imx6qdl.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 72a28d6..14c9726 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1092,6 +1092,34 @@
 					};
 				};
 
+				usdhc1 {
+					pinctrl_usdhc1_1: usdhc1grp-1 {
+						fsl,pins = <
+							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
+							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
+							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
+							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
+							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+							MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
+							MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
+							MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
+							MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17059
+						>;
+					};
+
+					pinctrl_usdhc1_2: usdhc1grp-2 {
+						fsl,pins = <
+							MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
+							MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
+							MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
+							MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
+							MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
+							MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+						>;
+					};
+				};
+
 				usdhc2 {
 					pinctrl_usdhc2_1: usdhc2grp-1 {
 						fsl,pins = <
-- 
1.8.1.2
