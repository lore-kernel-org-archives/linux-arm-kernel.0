From: marex@denx.de (Marek Vasut)
Date: Sun, 21 Apr 2013 23:30:01 +0200
Subject: [PATCH 1/8] ARM: mx5: Add AUDMUX4 pinctrl data
Message-ID: <1366579808-12067-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl data for the AUDMUX4 on MX53.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c4ddf51..fb701bb 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -298,6 +298,15 @@
 							MX53_PAD_KEY_ROW1__AUDMUX_AUD5_RXD  0x80000000
 						>;
 					};
+
+					pinctrl_audmux_2: audmuxgrp-2 {
+						fsl,pins = <
+							MX53_PAD_SD2_DATA3__AUDMUX_AUD4_TXC	0x80000000
+							MX53_PAD_SD2_DATA2__AUDMUX_AUD4_TXD	0x80000000
+							MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS	0x80000000
+							MX53_PAD_SD2_DATA0__AUDMUX_AUD4_RXD	0x80000000
+						>;
+					};
 				};
 
 				fec {
-- 
1.7.10.4
