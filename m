From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 2 Apr 2018 16:09:01 +0530
Subject: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
 has_axieth_connected
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
Message-ID: <1522665546-10035-2-git-send-email-radheys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional AXI DMA property 'has_axieth_connected'. This can be
specified to indicate that AXI DMA is connected to AXI Ethernet in
hardware design and dma driver needs to do some additional handling.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfa..5d592e3 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -42,6 +42,7 @@ Optional properties:
 	the hardware.
 Optional properties for AXI DMA:
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
+- xlnx,axieth-connected: Tells whether AXI DMA is connected to AXI Ethernet.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
1.7.1
