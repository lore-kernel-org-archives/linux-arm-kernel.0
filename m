From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  6 Jul 2018 19:50:57 +0200
Subject: [PATCH 01/17] dt-bindings: display: sun4i-drm: Add R40 display engine
 compatible
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Message-ID: <20180706175113.26698-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R40 has pretty unique display pipeline. It supports two outputs at the
same time.

Possible outputs:
- 1x HDMI,
- 2x TV output
- 1x VGA,
- 1x MIPI DSI and
- 2x LCD outputs

That is the biggest number of possible outputs from all Allwinner SoC.
Because of that, add new compatible for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 5a9319ad8861..288b4cbc255e 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -399,6 +399,7 @@ Required properties:
     * allwinner,sun8i-a33-display-engine
     * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-h3-display-engine
+    * allwinner,sun8i-r40-display-engine
     * allwinner,sun8i-v3s-display-engine
     * allwinner,sun9i-a80-display-engine
 
-- 
2.18.0
