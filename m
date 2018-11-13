From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 17:30:53 +0530
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-utgard: Add compatible for A64
 Mali
Message-ID: <20181113120054.17639-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has Mali-400MP2, so document the relevant compatible
as "allwinner,sun50i-a64-mali"

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- New patch, separated from previous version patch.

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..a0ee62a5b221 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -11,6 +11,7 @@ Required properties:
       + allwinner,sun4i-a10-mali
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
+      + allwinner,sun50i-a64-mali
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
-- 
2.18.0.321.gffc6fa0e3
