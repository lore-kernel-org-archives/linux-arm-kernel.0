From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 16 Jun 2016 16:13:18 +0800
Subject: [PATCH] dt-bindings: ci-hdrc-usb2: s/gadget-itc-setting/itc-setting
 in example
Message-ID: <1466064798-867-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What the code expect is "itc-setting" rather than "gadget-itc-setting",
and this is also correctly described in the optional properties.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 1084e2b..341dc67 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -93,7 +93,7 @@ Example:
 		phys = <&usb_phy0>;
 		phy-names = "usb-phy";
 		vbus-supply = <&reg_usb0_vbus>;
-		gadget-itc-setting = <0x4>; /* 4 micro-frames */
+		itc-setting = <0x4>; /* 4 micro-frames */
 		 /* Incremental burst of unspecified length */
 		ahb-burst-config = <0x0>;
 		tx-burst-size-dword = <0x10>; /* 64 bytes */
-- 
2.8.1
