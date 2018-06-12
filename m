From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:25 +0200
Subject: [PATCH v2 16/27] dt-bindings: display: sun4i-drm: Add R40 mixer
 compatibles
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-17-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R40 DE2 mixers are similar to those found in A83T, except it needs
different clock settings.

Add a compatibles for them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 68c4b2995624..d84df6d808c2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -358,6 +358,8 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-0
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
+    * allwinner,sun8i-r40-de2-mixer-0
+    * allwinner,sun8i-r40-de2-mixer-1
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
-- 
2.17.1
