From: b32955@freescale.com (Huang Shijie)
Date: Mon, 1 Jul 2013 15:57:14 +0800
Subject: [PATCH] ARM: dts: imx6: add #dma-cells property for sdma
Message-ID: <1372665434-2515-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the #dma-cells property for imx6 sdma.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 arch/arm/boot/dts/imx6sl.dtsi  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b381c85..ec5552b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -581,6 +581,7 @@
 				interrupts = <0 2 0x04>;
 				clocks = <&clks 155>, <&clks 155>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c5e5da0..9138c67 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -594,6 +594,7 @@
 				clocks = <&clks IMX6SL_CLK_SDMA>,
 					 <&clks IMX6SL_CLK_SDMA>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
 			};
 
-- 
1.7.1
