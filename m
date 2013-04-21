From: marex@denx.de (Marek Vasut)
Date: Sun, 21 Apr 2013 23:30:02 +0200
Subject: [PATCH 2/8] ARM: mx5: Add CAN1 pinctrl data
In-Reply-To: <1366579808-12067-1-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
Message-ID: <1366579808-12067-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl data for different mux of CAN1 on MX53.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index fb701bb..6a2f5a8 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -446,6 +446,13 @@
 							MX53_PAD_KEY_ROW2__CAN1_RXCAN 0x80000000
 						>;
 					};
+
+					pinctrl_can1_3: can1grp-3 {
+						fsl,pins = <
+							MX53_PAD_GPIO_7__CAN1_TXCAN	0x80000000
+							MX53_PAD_GPIO_8__CAN1_RXCAN	0x80000000
+						>;
+					};
 				};
 
 				can2 {
-- 
1.7.10.4
