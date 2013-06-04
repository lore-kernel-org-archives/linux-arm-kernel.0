From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:15 +0200
Subject: [PATCH 8/8] ARM i.MX53: mba53: add DI1_CLK to pinctrl for disp1
In-Reply-To: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1370344035-7417-9-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

Add missing pin config

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 869aa3e..aaa33bc 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -98,6 +98,7 @@
 	disp1 {
 		pinctrl_disp1_1: disp1-grp1 {
 			fsl,pins = <
+				MX53_PAD_EIM_A16__IPU_DI1_DISP_CLK 0x80000000 /* DISP1_CLK */
 				MX53_PAD_EIM_DA10__IPU_DI1_PIN15   0x80000000 /* DISP1_DRDY */
 				MX53_PAD_EIM_D23__IPU_DI1_PIN2     0x80000000 /* DISP1_HSYNC */
 				MX53_PAD_EIM_EB3__IPU_DI1_PIN3     0x80000000 /* DISP1_VSYNC */
-- 
1.8.2.rc2
