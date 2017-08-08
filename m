From: net147@gmail.com (Jonathan Liu)
Date: Tue,  8 Aug 2017 11:25:40 +1000
Subject: [PATCH] dt-bindings: clock: sunxi-ccu: Add compatibles for sun5i CCU
 driver
Message-ID: <20170808012540.16691-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bindings were not updated when the sun5i CCU driver was added in
commit 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver").

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index df9fad58facd..dbe0c1c58ab5 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -3,6 +3,8 @@ Allwinner Clock Control Unit Binding
 
 Required properties :
 - compatible: must contain one of the following compatibles:
+		- "allwinner,sun5i-a10s-ccu"
+		- "allwinner,sun5i-a13-ccu"
 		- "allwinner,sun6i-a31-ccu"
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
@@ -15,6 +17,7 @@ Required properties :
 		- "allwinner,sun50i-a64-ccu"
 		- "allwinner,sun50i-a64-r-ccu"
 		- "allwinner,sun50i-h5-ccu"
+		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
 - clocks: phandle to the oscillators feeding the CCU. Two are needed:
-- 
2.13.2
