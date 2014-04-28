From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 16:12:34 +0200
Subject: [PATCH 1/3] arm: dts: imx6qdl, remove fsl,ssi-dma-events
In-Reply-To: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398694356-22511-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All dtsi files where already moved to generic dma bindings. Remove the
old non-generic DMA properties.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 947e463..b230c09 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -261,7 +261,6 @@
 					       <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <38 37>;
 					status = "disabled";
 				};
 
@@ -276,7 +275,6 @@
 					       <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <42 41>;
 					status = "disabled";
 				};
 
@@ -291,7 +289,6 @@
 					       <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <46 45>;
 					status = "disabled";
 				};
 
-- 
1.9.1
