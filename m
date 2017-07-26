From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 26 Jul 2017 18:56:24 -0400
Subject: [PATCH v2 3/6] dt-bindings: usb: Add documentation for NS2 ICFG USB3
In-Reply-To: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
References: <1501109787-15489-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1501109787-15489-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for ICFG USB3 registers available in NS2 SoC

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt b/Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt
new file mode 100644
index 000000000000..72176e25a692
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,icfg-usb.txt
@@ -0,0 +1,13 @@
+Broadcom ICFG USB3 registers
+
+Required properties:
+- compatible: "brcm,icfg-usb"
+- reg: Base address and length of the USB registers
+
+
+Example:
+
+icfg_usb3: icfg_usb3 at 66000900 {
+        compatible = "brcm,icfg-usb";
+        reg = <0x66000900 0x60>;
+};
-- 
2.7.4
