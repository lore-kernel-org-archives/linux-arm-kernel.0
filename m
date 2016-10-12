From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 12 Oct 2016 13:17:28 +0530
Subject: [PATCH v6 2/2] devicetree: bindings: uart: Add new compatible string
 for ZynqMP
In-Reply-To: <1476258448-20483-1-git-send-email-navam@xilinx.com>
References: <1476258448-20483-1-git-send-email-navam@xilinx.com>
Message-ID: <1476258448-20483-2-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Adds the new compatible string for ZynqMP SoC.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v6:
		-Added New compatiable string for ZynqMP SoC as
		 suggested by Rob Herring.
Changes for v5:
		-Mofified the compatible session.
Changes for v4:
                -Modified the ChangeLog comment.
Changes for v3:
                -Added changeLog comment.
Changes for v2:
                -None

 Documentation/devicetree/bindings/serial/cdns,uart.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
index a3eb154..227bb77 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
@@ -1,7 +1,9 @@
 Binding for Cadence UART Controller
 
 Required properties:
-- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
+- compatible :
+  Use "xlnx,xuartps","cdns,uart-r1p8" for Zynq-7xxx SoC.
+  Use "xlnx,zynqmp-uart","cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
 - reg: Should contain UART controller registers location and length.
 - interrupts: Should contain UART controller interrupts.
 - clocks: Must contain phandles to the UART clocks
-- 
2.1.1
