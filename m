From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 3 Jan 2018 19:22:14 +0800
Subject: [PATCH] ARM: dts: imx6ul: remove unnecessary clocks for cpu-freq
Message-ID: <1514978534-27416-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary clocks for cpu-freq driver to
avoid confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 86b3251..fb06a9a 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -86,15 +86,10 @@
 				 <&clks IMX6UL_CA7_SECONDARY_SEL>,
 				 <&clks IMX6UL_CLK_STEP>,
 				 <&clks IMX6UL_CLK_PLL1_SW>,
-				 <&clks IMX6UL_CLK_PLL1_SYS>,
-				 <&clks IMX6UL_PLL1_BYPASS>,
-				 <&clks IMX6UL_CLK_PLL1>,
-				 <&clks IMX6UL_PLL1_BYPASS_SRC>,
-				 <&clks IMX6UL_CLK_OSC>;
+				 <&clks IMX6UL_CLK_PLL1_SYS>;
 			clock-names = "arm", "pll2_bus",  "pll2_pfd2_396m",
 				      "secondary_sel", "step", "pll1_sw",
-				      "pll1_sys", "pll1_bypass", "pll1",
-				      "pll1_bypass_src", "osc";
+				      "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
 		};
-- 
1.9.1
