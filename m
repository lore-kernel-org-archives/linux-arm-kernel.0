From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 21 Jan 2015 13:55:09 +0900
Subject: [PATCH 13/13] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
In-Reply-To: <20150121045256.7648.7451.sendpatchset@little-apple>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
Message-ID: <20150121045509.7648.3018.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the DT compatible string entry for the now unsupported sh7372 SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- 0001/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ work/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt	2015-01-21 12:12:15.357561911 +0900
@@ -1,7 +1,7 @@
 * Renesas Pin Function Controller (GPIO and Pin Mux/Config)
 
-The Pin Function Controller (PFC) is a Pin Mux/Config controller. On SH7372,
-SH73A0, R8A73A4 and R8A7740 it also acts as a GPIO controller.
+The Pin Function Controller (PFC) is a Pin Mux/Config controller. On SH73A0,
+R8A73A4 and R8A7740 it also acts as a GPIO controller.
 
 
 Pin Control
@@ -16,7 +16,6 @@ Required Properties:
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
     - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2) compatible pin-controller.
-    - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
     - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
 
   - reg: Base address and length of each memory resource used by the pin
@@ -75,8 +74,7 @@ bias-disable, bias-pull-up and bias-pull
 GPIO
 ----
 
-On SH7372, SH73A0, R8A73A4 and R8A7740 the PFC node is also a GPIO controller
-node.
+On SH73A0, R8A73A4 and R8A7740 the PFC node is also a GPIO controller node.
 
 Required Properties:
 
