From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 15:09:28 +0530
Subject: [PATCH v2 1/3] arm: dts: imx6qdl: Fix "WARNING: please,
 no space before tabs"
In-Reply-To: <1476437970-15800-1-git-send-email-jteki@openedev.com>
References: <1476437970-15800-1-git-send-email-jteki@openedev.com>
Message-ID: <1476437970-15800-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed no space before tabs warnings in respetcive imx6qdl dtsi files.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jteki@openedev.com>
---
Changes for v2:
	- none

 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi   | 14 +++++++-------
 arch/arm/boot/dts/imx6qdl-tx6.dtsi       | 32 ++++++++++++++++----------------
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi |  4 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index edbce22..5e7792d 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -347,13 +347,13 @@
 			fsl,pins = <
 				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x100b1
 				MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x100b1
-				MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13 	0x100b1
-				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14 	0x100b1
-				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15 	0x100b1
-				MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16 	0x100b1
-				MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17 	0x100b1
-				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18 	0x100b1
-				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21  	0x100b1
+				MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x100b1
+				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x100b1
+				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x100b1
+				MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16	0x100b1
+				MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x100b1
+				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x100b1
+				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x100b1
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index ac9529f..2bf2e62 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -429,8 +429,8 @@
 	pinctrl_edt_ft5x06: edt-ft5x06grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0 /* Interrupt */
-			MX6QDL_PAD_EIM_A16__GPIO2_IO22  	0x1b0b0 /* Reset */
-			MX6QDL_PAD_EIM_A17__GPIO2_IO21  	0x1b0b0 /* Wake */
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x1b0b0 /* Reset */
+			MX6QDL_PAD_EIM_A17__GPIO2_IO21		0x1b0b0 /* Wake */
 		>;
 	};
 
@@ -481,21 +481,21 @@
 
 	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE    	0x0b0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE    	0x0b0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B  	0x0b0b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0x0b0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0x0b0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0x0b0b1
 			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0x0b000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B  	0x0b0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B     	0x0b0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B     	0x0b0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00  	0x0b0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01  	0x0b0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02  	0x0b0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03  	0x0b0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04  	0x0b0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05  	0x0b0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06  	0x0b0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07  	0x0b0b1
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0x0b0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0x0b0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0x0b0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0x0b0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0x0b0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0x0b0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0x0b0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0x0b0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0x0b0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0x0b0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0x0b0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 2b9c2be..82dc5744 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -129,8 +129,8 @@
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL 		0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA 		0x4001b8b1
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 			>;
 		};
 
-- 
2.7.4
