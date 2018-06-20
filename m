From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 10:36:53 +0200
Subject: [PATCH 6/6] dt-bindings: xilinx_dma: drop has-sg property
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Message-ID: <20180620083653.17010-6-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is not needed anymore, because the driver now autodetects it.
Delete references in documentation.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index acecdc5d8d47..53341314eeb8 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -39,9 +39,6 @@ Required properties for VDMA:
 Required properties for AXI DMA:
 - xlnx,lengthregwidth: Should be the width of the length register as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
-- 
2.17.1
