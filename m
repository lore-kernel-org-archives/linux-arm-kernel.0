From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Jun 2017 11:04:39 +0200
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: Add Libre Technology CC
 board
In-Reply-To: <20170619090440.27099-1-jbrunet@baylibre.com>
References: <20170619090440.27099-1-jbrunet@baylibre.com>
Message-ID: <20170619090440.27099-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for the CC board from Shenzhen Libre
Technology

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 5c01e65951fa..0fff40a6330d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -52,6 +52,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p212" (Meson gxl s905x)
   - "hwacom,amazetv" (Meson gxl s905x)
   - "khadas,vim" (Meson gxl s905x)
+  - "libretech,cc" (Meson gxl s905x)
 
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
-- 
2.9.4
