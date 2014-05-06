From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  6 May 2014 02:14:09 +0200
Subject: [PATCH v3 14/20] xhci-platform: Add a new controller using xHCI:
 Armada 375
In-Reply-To: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
References: <1399335255-589-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1399335255-589-15-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the compatible string list with armada-375-xhci. It is used to
describe xHCI controller which is in the Armada 375 SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index a0915941fc25..5eafa9a4e136 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -2,7 +2,8 @@ USB xHCI controllers
 
 Required properties:
   - compatible: should be one of "generic-xhci",
-    "marvell,armada-380-xhci" (deprecated: "xhci-platform").
+    "marvell,armada-375-xhci", "marvell,armada-380-xhci" (deprecated:
+    "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
-- 
1.8.1.2
