From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 9 Oct 2013 19:20:09 +0800
Subject: [PATCH 03/10] ARM: dts: imx6sl: change usdhc compatible with imx6sl
 only
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Message-ID: <1381317616-1229-4-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uSDHC on i.MX6SL is a little different from i.MX6Q,
especially on SD3.0 tuning part,
This change makes it work on i.MX6SL mode only to utilize the features
introduced in i.MX6SL.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d0ae4c6..f72b1d6 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -774,7 +774,7 @@
 			};
 
 			usdhc1: usdhc at 02190000 {
-				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
+				compatible = "fsl,imx6sl-usdhc";
 				reg = <0x02190000 0x4000>;
 				interrupts = <0 22 0x04>;
 				clocks = <&clks IMX6SL_CLK_USDHC1>,
@@ -786,7 +786,7 @@
 			};
 
 			usdhc2: usdhc at 02194000 {
-				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
+				compatible = "fsl,imx6sl-usdhc";
 				reg = <0x02194000 0x4000>;
 				interrupts = <0 23 0x04>;
 				clocks = <&clks IMX6SL_CLK_USDHC2>,
@@ -798,7 +798,7 @@
 			};
 
 			usdhc3: usdhc at 02198000 {
-				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
+				compatible = "fsl,imx6sl-usdhc";
 				reg = <0x02198000 0x4000>;
 				interrupts = <0 24 0x04>;
 				clocks = <&clks IMX6SL_CLK_USDHC3>,
@@ -810,7 +810,7 @@
 			};
 
 			usdhc4: usdhc at 0219c000 {
-				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
+				compatible = "fsl,imx6sl-usdhc";
 				reg = <0x0219c000 0x4000>;
 				interrupts = <0 25 0x04>;
 				clocks = <&clks IMX6SL_CLK_USDHC4>,
-- 
1.7.2.rc3
