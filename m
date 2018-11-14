From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 14 Nov 2018 09:58:36 +0530
Subject: [PATCH v3 1/2] dt-bindings: gpu: mali-utgard: Add compatible for A64
 Mali
Message-ID: <20181114042837.15149-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has Mali-400MP2, so document the relevant compatible
as "allwinner,sun50i-a64-mali" along with reset line.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- document reset line
Changes for v2:
- New patch, separated from previous version patch.

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..3f128e4f95c6 100644
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
@@ -73,6 +74,10 @@ to specify one more vendor-specific compatible, among:
     Required properties:
       * resets: phandle to the reset line for the GPU
 
+  - allwinner,sun50i-a64-mali
+    Required properties:
+      * resets: phandle to the reset line for the GPU
+
   - allwinner,sun50i-h5-mali
     Required properties:
       * resets: phandle to the reset line for the GPU
-- 
2.18.0.321.gffc6fa0e3
