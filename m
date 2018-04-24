From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 24 Apr 2018 19:04:20 +0530
Subject: [RFC 08/13] bindings: display: Add compatible for A64 HDMI PHY
In-Reply-To: <20180424133425.24291-1-jagan@amarulasolutions.com>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
Message-ID: <20180424133425.24291-9-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI PHY on Allwinner A64 has similar like H3/H5.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 98b3f5aae117..448f99a91382 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -104,6 +104,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-a83t-hdmi-phy
     * allwinner,sun8i-h3-hdmi-phy
+    * allwinner,sun50i-a64-hdmi-phy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the HDMI PHY
     * bus: the HDMI PHY interface clock
-- 
2.14.3
