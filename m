From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jul 2013 09:49:31 -0300
Subject: [PATCH v3 2/4] ARM: dts: imx6qdl.dtsi: Add another uart3 pin group
In-Reply-To: <1373633373-3352-1-git-send-email-festevam@gmail.com>
References: <1373633373-3352-1-git-send-email-festevam@gmail.com>
Message-ID: <1373633373-3352-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- None. Newly introduced in this series

 arch/arm/boot/dts/imx6qdl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 14c9726..b564d74 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1037,6 +1037,15 @@
 							MX6QDL_PAD_EIM_EB3__UART3_RTS_B   0x1b0b1
 						>;
 					};
+
+					pinctrl_uart3_2: uart3grp-2 {
+						fsl,pins = <
+							MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
+							MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
+							MX6QDL_PAD_EIM_D23__UART3_CTS_B	  0x1b0b1
+							MX6QDL_PAD_EIM_EB3__UART3_RTS_B	  0x1b0b1
+						>;
+					};
 				};
 
 				uart4 {
-- 
1.8.1.2
