From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 31 Jul 2016 19:25:34 +0800
Subject: [PATCH 1/3] dt: bindings: add bindings for Allwinner A64 usb phy
Message-ID: <20160731112536.4625-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 95736d7..287150d 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -10,6 +10,7 @@ Required properties:
   * allwinner,sun8i-a23-usb-phy
   * allwinner,sun8i-a33-usb-phy
   * allwinner,sun8i-h3-usb-phy
+  * allwinner,sun50i-a64-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
   * "phy_ctrl"
-- 
2.9.0
