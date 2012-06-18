From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 18:28:42 -0300
Subject: [PATCH] ARM: imx28.dtsi: Add pinmux for additional AUART ports
Message-ID: <1340054922-16092-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add pinmux for additional AUART ports.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index ee3778a..c98d17a 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -197,6 +197,21 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart1_pins_a: auart1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3040 0x3050 0x3060 0x3070>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				auart2_pins_a: auart2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3080 0x3090 0x30a0 0x30b0>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x30c0 0x30d0 0x30e0 0x30f0>;
-- 
1.7.1
