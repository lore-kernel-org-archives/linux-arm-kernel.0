From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:17 +0530
Subject: [PATCH 10/11] Documentation: Rename gpio controller name from cygnus
 to iproc
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-11-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renamed gpio controller's driver name from cygnus to iproc to make it
more generic so that all iProc based SoCs having the same gpio controller
could use this.

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../bindings/pinctrl/{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt}    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,cygnus-gpio.txt => brcm,iproc-gpio.txt} (97%)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
similarity index 97%
rename from Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
rename to Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
index 655a8d7..7fb4621 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,iproc-gpio.txt
@@ -1,4 +1,4 @@
-Broadcom Cygnus GPIO/PINCONF Controller
+Broadcom iProc GPIO/PINCONF Controller
 
 Required properties:
 
@@ -7,7 +7,7 @@ Required properties:
 "brcm,cygnus-crmu-gpio" or "brcm,iproc-gpio"
 
 - reg:
-    Define the base and range of the I/O address space that contains the Cygnus
+    Define the base and range of the I/O address space that contains SoC
 GPIO/PINCONF controller registers
 
 - ngpios:
-- 
1.9.1
