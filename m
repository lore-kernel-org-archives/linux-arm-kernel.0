From: eric@engestrom.ch (Eric Engestrom)
Date: Mon, 25 Apr 2016 01:24:08 +0100
Subject: [PATCH 11/41] Documentation: dt: dma: fix spelling mistake
In-Reply-To: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
Message-ID: <1461543878-3639-12-git-send-email-eric@engestrom.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 2291c40..3cf0072d 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -7,7 +7,7 @@ Required properties:
 - compatible: Should be "xlnx,axi-dma-1.00.a"
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain DMA registers location and length.
-- dma-channel child node: Should have atleast one channel and can have upto
+- dma-channel child node: Should have at least one channel and can have up to
 	two channels per device. This node specifies the properties of each
 	DMA channel (see child node properties below).
 
-- 
2.8.0
