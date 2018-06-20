From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 10:36:50 +0200
Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required xlnx,
 lengthregwidth property
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Message-ID: <20180620083653.17010-3-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add DOC for it.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..acecdc5d8d47 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -36,6 +36,8 @@ Required properties:
 
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
+Required properties for AXI DMA:
+- xlnx,lengthregwidth: Should be the width of the length register as configured in h/w.
 
 Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
-- 
2.17.1
