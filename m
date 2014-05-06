From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:02 +0200
Subject: [PATCH v3 07/20] xhci-platform: Add a new controller using xhci:
 Armada 38x
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-8-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the compatible string list with armada-380-xhci. It is used to
describe xhci controller which is in the Armada 38x SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 90f8f607d125..a0915941fc25 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -1,7 +1,8 @@
 USB xHCI controllers
 
 Required properties:
-  - compatible: should be "generic-xhci" (deprecated: "xhci-platform").
+  - compatible: should be one of "generic-xhci",
+    "marvell,armada-380-xhci" (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
-- 
1.8.1.2
