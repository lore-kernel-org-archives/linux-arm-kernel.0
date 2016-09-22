From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Thu, 22 Sep 2016 16:56:19 +0530
Subject: [PATCH v4] devicetree: bindings: uart: Add new compatible string for
 ZynqMP
Message-ID: <1474543579-40312-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Adds the new compatible string for ZynqMP.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v4:
		-Modified the ChangeLog comment.
Changes for v3:
		-Added changeLog comment.
Changes for v2:
                -None

 Documentation/devicetree/bindings/serial/cdns,uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
index a3eb154..4fe7aae 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -1,7 +1,8 @@
 Binding for Cadence UART Controller
 
 Required properties:
-- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq and
+               "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC uart controller.
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain phandles to the UART clocks
-- 
2.1.2
