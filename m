From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Apr 2016 16:33:06 +0800
Subject: [PATCH 1/3] arm: dts: imx6qdl: add clocks property for ocotp node
Message-ID: <1461054788-339-1-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks property for ocotp node.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b42822a..6b2ef6c 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1100,6 +1100,7 @@
 			ocotp: ocotp at 021bc000 {
 				compatible = "fsl,imx6q-ocotp", "syscon";
 				reg = <0x021bc000 0x4000>;
+				clocks = <&clks IMX6QDL_CLK_IIM>;
 			};
 
 			tzasc at 021d0000 { /* TZASC1 */
-- 
1.8.4.5
