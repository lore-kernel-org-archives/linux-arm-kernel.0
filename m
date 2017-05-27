From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 27 May 2017 18:23:03 +0800
Subject: [PATCH v3 05/10] dt-bindings: add compatible string for Allwinner R40
 pinctrl
In-Reply-To: <20170527102308.1988-1-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
Message-ID: <20170527102308.1988-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 has a pin controller like the ones in older Allwinner SoCs
(especially A20), and can use modified version of the A10/A20 pinctrl
driver.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- Added Rob's ACK.

 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index b53224473672..3ab9f7849a19 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -22,6 +22,7 @@ Required properties:
   "allwinner,sun8i-a83t-pinctrl"
   "allwinner,sun8i-h3-pinctrl"
   "allwinner,sun8i-h3-r-pinctrl"
+  "allwinner,sun8i-r40-pinctrl"
   "allwinner,sun50i-a64-pinctrl"
   "allwinner,sun50i-a64-r-pinctrl"
   "allwinner,sun50i-h5-pinctrl"
-- 
2.12.2
