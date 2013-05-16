From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 16 May 2013 11:13:58 -0300
Subject: [PATCH 1/2] ARM: dts: imx: Remove custom dma-channel bindings
Message-ID: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f30fb03 (ARM: dts: add generic DMA device tree binding for mxs-dma) added
the generic DMA dt bindings, but missed to remove the old ones.

Remove the the old dma bindings.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23.dtsi   | 3 ---
 arch/arm/boot/dts/imx28.dtsi   | 5 -----
 arch/arm/boot/dts/imx6qdl.dtsi | 1 -
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 73fd7d0..be93494 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -78,7 +78,6 @@
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -88,7 +87,6 @@
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
@@ -366,7 +364,6 @@
 				clocks = <&clks 33>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e401dee..33389b8 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -100,7 +100,6 @@
 				clock-names = "gpmi_io";
 				dmas = <&dma_apbh 4>;
 				dma-names = "rx-tx";
-				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -112,7 +111,6 @@
 				clocks = <&clks 46>;
 				dmas = <&dma_apbh 0>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
 
@@ -124,7 +122,6 @@
 				clocks = <&clks 47>;
 				dmas = <&dma_apbh 1>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
@@ -136,7 +133,6 @@
 				clocks = <&clks 48>;
 				dmas = <&dma_apbh 2>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
@@ -148,7 +144,6 @@
 				clocks = <&clks 49>;
 				dmas = <&dma_apbh 3>;
 				dma-names = "rx-tx";
-				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 42e461c..5cc2855 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -89,7 +89,6 @@
 				      "gpmi_bch_apb", "per1_bch";
 			dmas = <&dma_apbh 0>;
 			dma-names = "rx-tx";
-			fsl,gpmi-dma-channel = <0>;
 			status = "disabled";
 		};
 
-- 
1.8.1.2
