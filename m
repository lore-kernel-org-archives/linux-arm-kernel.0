From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 19 Aug 2014 15:21:13 -0300
Subject: [PATCH 3/4] ARM: dts: imx6sl-evk.dts: Keep pinctrl nodes sorted
In-Reply-To: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
References: <1408472474-4914-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1408472474-4914-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's keep pinctrl nodes sorted.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 3f9e041..366eb02 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -329,12 +329,6 @@
 			>;
 		};
 
-		pinctrl_led: ledgrp {
-			fsl,pins = <
-				MX6SL_PAD_HSIC_STROBE__GPIO3_IO20 0x17059
-			>;
-		};
-
 		pinctrl_kpp: kppgrp {
 			fsl,pins = <
 				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
@@ -346,6 +340,12 @@
 			>;
 		};
 
+		pinctrl_led: ledgrp {
+			fsl,pins = <
+				MX6SL_PAD_HSIC_STROBE__GPIO3_IO20 0x17059
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SL_PAD_UART1_RXD__UART1_RX_DATA	0x1b0b1
-- 
1.9.1
