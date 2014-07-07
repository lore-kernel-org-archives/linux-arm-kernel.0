From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 7 Jul 2014 10:04:52 -0300
Subject: [PATCH] ARM: imx6: Align ssi nodes between mx6 variants
Message-ID: <1404738292-8843-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 98ea6ad2edd2 (ARM: dts: imx6: use imx51-ssi) the mx6 ssi is 
compatible with imx51, so align all the mx6 variant ssi compatible strings as:

compatible = "fsl,<imx6-soc>-ssi", "fsl,imx51-ssi";

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 9 +++------
 arch/arm/boot/dts/imx6sl.dtsi  | 9 +++------
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d7c97d9..c701af9 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -274,8 +274,7 @@
 
 				ssi1: ssi at 02028000 {
 					compatible = "fsl,imx6q-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_SSI1_IPG>;
@@ -288,8 +287,7 @@
 
 				ssi2: ssi at 0202c000 {
 					compatible = "fsl,imx6q-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_SSI2_IPG>;
@@ -302,8 +300,7 @@
 
 				ssi3: ssi at 02030000 {
 					compatible = "fsl,imx6q-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6QDL_CLK_SSI3_IPG>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c0ee12f..68ce59b7 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -227,8 +227,7 @@
 
 				ssi1: ssi at 02028000 {
 					compatible = "fsl,imx6sl-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
@@ -241,8 +240,7 @@
 
 				ssi2: ssi at 0202c000 {
 					compatible = "fsl,imx6sl-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
@@ -255,8 +253,7 @@
 
 				ssi3: ssi at 02030000 {
 					compatible = "fsl,imx6sl-ssi",
-							"fsl,imx51-ssi",
-							"fsl,imx21-ssi";
+							"fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5e31c5c..c3111f0 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -323,7 +323,7 @@
 				};
 
 				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
@@ -336,7 +336,7 @@
 				};
 
 				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_SSI2_IPG>,
@@ -349,7 +349,7 @@
 				};
 
 				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_SSI3_IPG>,
-- 
1.8.3.2
