From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:32 +0200
Subject: [PATCH 4/7] arm: dts: imx6qdl, remove fsl,ssi-dma-events
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All dtsi files where already moved to generic dma bindings. Remove the
old non-generic DMA properties.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ce0599134a69..d2393d77a82e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -272,7 +272,6 @@
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <38 37>;
 					status = "disabled";
 				};
 
@@ -287,7 +286,6 @@
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <42 41>;
 					status = "disabled";
 				};
 
@@ -302,7 +300,6 @@
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <46 45>;
 					status = "disabled";
 				};
 
-- 
2.0.0
