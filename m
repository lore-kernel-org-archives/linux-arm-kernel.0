From: jonas@microbit.se (Jonas Andersson)
Date: Mon, 27 May 2013 10:52:21 +0200
Subject: [PATCH] ARM: dts: imx53: add cspi pinctrl
Message-ID: <1369644741-17153-1-git-send-email-jonas@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a group to the cspi pinctrl.

Signed-off-by: Jonas Andersson <jonas@microbit.se>
---
 arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index eb83aa0..024616c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -322,6 +322,14 @@
 							MX53_PAD_SD1_CLK__CSPI_SCLK   0x1d5
 						>;
 					};
+
+					pinctrl_cspi_2: cspigrp-2 {
+						fsl,pins = <
+							MX53_PAD_EIM_D22__CSPI_MISO 0x1d5
+							MX53_PAD_EIM_D28__CSPI_MOSI 0x1d5
+							MX53_PAD_EIM_D21__CSPI_SCLK 0x1d5
+						>;
+					};
 				};
 
 				ecspi1 {
-- 
1.8.1.4
