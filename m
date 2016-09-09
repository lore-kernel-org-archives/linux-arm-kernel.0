From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Fri, 9 Sep 2016 16:23:22 +0530
Subject: [PATCH 2/2] devicetree: bindings: uart: Add new compatible string for
 ZynqMP
In-Reply-To: <1473418402-34855-1-git-send-email-navam@xilinx.com>
References: <1473418402-34855-1-git-send-email-navam@xilinx.com>
Message-ID: <1473418402-34855-2-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
[stelford at cadence.com: cherry picked from
https://github.com/Xilinx/linux-xlnx commit
37b8a9780766422b2437f5166ddef3767bb60887]
Signed-off-by: Scott Telford <stelford@cadence.com>
---
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
