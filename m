From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:20:24 +0900
Subject: [PATCH] serial: sh-sci: Add device tree support for r8a779[23]
Message-ID: <1448587224-8633-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply document new compat strings.
There appears to be no need for a driver updates.

Also update the name of the r8a7791 to M2-W: the name changed a while back.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e84b13a8eda3..38bb05223f47 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -15,10 +15,16 @@ Required properties:
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
     - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
     - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
-    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2) SCIF compatible UART.
-    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
-    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
-    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2-W) SCIF compatible UART.
+    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2-W) SCIFA compatible UART.
+    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2-W) SCIFB compatible UART.
+    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2-W) HSCIF compatible UART.
+    - "renesas,scif-r8a7792" for R8A7792 (R-Car V2H) SCIF compatible UART.
+    - "renesas,hscif-r8a7792" for R8A7792 (R-Car V2H) HSCIF compatible UART.
+    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2-N) SCIF compatible UART.
+    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2-N) SCIFA compatible UART.
+    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2-N) SCIFB compatible UART.
+    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2-N) HSCIF compatible UART.
     - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
     - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
     - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
-- 
2.1.4
