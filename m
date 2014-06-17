From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:31 +0200
Subject: [PATCH 3/7] ARM: dts: imx5*, remove fsl,ssi-dma-events
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All imx5*.dtsi files define the generic dma bindings. Drop the old
non-generic fsl,ssi-dma-events.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 3 ---
 arch/arm/boot/dts/imx53.dtsi | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index bebbf3ba0d5e..17c05a6fa776 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -218,7 +218,6 @@
 					       <&sdma 25 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
 				};
 
@@ -508,7 +507,6 @@
 				       <&sdma 29 0 0>;
 				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
@@ -564,7 +562,6 @@
 				       <&sdma 47 0 0>;
 				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <47 46 37 35>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6456a0084388..d8d3f979f599 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -231,7 +231,6 @@
 					       <&sdma 25 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
 				};
 
@@ -661,7 +660,6 @@
 				       <&sdma 29 0 0>;
 				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
@@ -689,7 +687,6 @@
 				       <&sdma 47 0 0>;
 				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
-- 
2.0.0
