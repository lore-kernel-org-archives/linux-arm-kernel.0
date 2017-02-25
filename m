From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 15:42:14 +0800
Subject: [PATCH 1/3] dt-bindings: add compatible for the PWM controller on
 Allwinner A64
Message-ID: <20170225074216.64868-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 have a PWM controller like other Allwinner SoCs.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
index f1cbeefb3087..2f8315aafe22 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
@@ -7,6 +7,7 @@ Required properties:
     - "allwinner,sun5i-a13-pwm"
     - "allwinner,sun7i-a20-pwm"
     - "allwinner,sun8i-h3-pwm"
+    - "allwinner,sun50i-a64-pwm"
   - reg: physical base address and length of the controller's registers
   - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
     the cells format.
-- 
2.11.1
