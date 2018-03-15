From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Mar 2018 19:41:32 +0800
Subject: [PATCH 4/8] drm/sun4i: Add compatible strings for the A80 display
 pipeline
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Message-ID: <20180315114136.24747-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds compatible strings for the remaining documented
components of the Allwinner A80 display pipeline.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 671d75c76ad0..3346c1e2a7a0 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -191,7 +191,7 @@ DRC
 ---
 
 The DRC (Dynamic Range Controller), found in the latest Allwinner SoCs
-(A31, A23, A33), allows to dynamically adjust pixel
+(A31, A23, A33, A80), allows to dynamically adjust pixel
 brightness/contrast based on histogram measurements for LCD content
 adaptive backlight control.
 
@@ -201,6 +201,7 @@ Required properties:
     * allwinner,sun6i-a31-drc
     * allwinner,sun6i-a31s-drc
     * allwinner,sun8i-a33-drc
+    * allwinner,sun9i-a80-drc
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DRC
@@ -227,6 +228,7 @@ Required properties:
     * allwinner,sun6i-a31-display-backend
     * allwinner,sun7i-a20-display-backend
     * allwinner,sun8i-a33-display-backend
+    * allwinner,sun9i-a80-display-backend
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the frontend and backend
@@ -283,6 +285,7 @@ Required properties:
     * allwinner,sun6i-a31-display-frontend
     * allwinner,sun7i-a20-display-frontend
     * allwinner,sun8i-a33-display-frontend
+    * allwinner,sun9i-a80-display-frontend
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the frontend and backend
@@ -339,6 +342,7 @@ Required properties:
     * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-h3-display-engine
     * allwinner,sun8i-v3s-display-engine
+    * allwinner,sun9i-a80-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
     frontends (DE 1.0) or mixers (DE 2.0) available.
-- 
2.16.2
