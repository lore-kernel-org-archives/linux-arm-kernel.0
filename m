From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Mon, 26 Sep 2016 19:36:41 +0530
Subject: [PATCH v5] devicetree: bindings: uart: Add new compatible string for
 ZynqMP
Message-ID: <1474898801-36571-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Adds the new compatible string for ZynqMP SoC.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v5:
		-Fixed some minor comments.
Changes for v4:
                -Modified the ChangeLog comment.
Changes for v3:
                -Added changeLog comment.
Changes for v2:
                -None

 Documentation/devicetree/bindings/serial/cdns,uart.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
index a3eb154..30c885c 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -1,7 +1,9 @@
 Binding for Cadence UART Controller
 
 Required properties:
-- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- compatible :
+  Use "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq-7xxx SoC.
+  Use "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain phandles to the UART clocks
-- 
2.1.2
