From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  7 Aug 2018 12:38:38 +0530
Subject: [PATCH 3/3] ARM: dts: i.MX6: Use consistent node names for Engicam
 files
In-Reply-To: <20180807070838.24685-1-jagan@amarulasolutions.com>
References: <20180807070838.24685-1-jagan@amarulasolutions.com>
Message-ID: <20180807070838.24685-3-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use consistent pinctrl node names for Engicam dt files,
sufix 'grp' look consistent than actual node name

- pinctrl_gpmi_nand: gpmi-nand {
+ pinctrl_gpmi_nand: gpminandgrp {

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi     | 4 ++--
 arch/arm/boot/dts/imx6ul-geam.dts        | 2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 6feae392830e..ba93026ecee8 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -281,7 +281,7 @@
 };
 
 &iomuxc {
-	pinctrl_audmux: audmux {
+	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index d39966e80415..84d03c65f4c8 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -274,7 +274,7 @@
 };
 
 &iomuxc {
-	pinctrl_audmux: audmux {
+	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
 			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
@@ -313,7 +313,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
 			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index bf86a5e33fc5..e22ec5be2b78 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -292,7 +292,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
 			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index fe435484e69d..b1fa3f0a684d 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -239,7 +239,7 @@
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_CLE__RAWNAND_CLE         0xb0b1
 			MX6UL_PAD_NAND_ALE__RAWNAND_ALE         0xb0b1
-- 
2.18.0.321.gffc6fa0e3
