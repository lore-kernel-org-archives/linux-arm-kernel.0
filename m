From: b32955@freescale.com (Huang Shijie)
Date: Tue, 2 Jul 2013 10:15:29 +0800
Subject: [PATCH] ARM: dts: imx: add #dma-cells property for sdma
Message-ID: <1372731329-1016-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the #dma-cells property for all the sdma in all the imx platforms.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx25.dtsi   |    1 +
 arch/arm/boot/dts/imx51.dtsi   |    1 +
 arch/arm/boot/dts/imx53.dtsi   |    1 +
 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 arch/arm/boot/dts/imx6sl.dtsi  |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 7011539..1f72862 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -424,6 +424,7 @@
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				interrupts = <34>;
 			};
 
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 25764b5..40ab745 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -645,6 +645,7 @@
 				interrupts = <6>;
 				clocks = <&clks 56>, <&clks 56>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 569aa9f..78bcd9a 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -990,6 +990,7 @@
 				interrupts = <6>;
 				clocks = <&clks 56>, <&clks 56>;
 				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f21d259..0509344 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -582,6 +582,7 @@
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
