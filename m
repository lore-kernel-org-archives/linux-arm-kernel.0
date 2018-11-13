From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 16:46:30 +0530
Subject: [PATCH v4 23/26] dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
Message-ID: <20181113111633.20189-24-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index adc7cdf129dd..08f1f57abff5 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -40,6 +40,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3
