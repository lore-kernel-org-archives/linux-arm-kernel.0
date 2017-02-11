From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:01 +0200
Subject: [PATCH 4/8] drm/sun4i: Add optional 'mode' property to TCON
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-5-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add variable to enable either 'rgb' or 'lvds' output.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index b82c004..c367ede 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -43,6 +43,9 @@ Required properties:
  - reset-names: the reset names mentioned above
  - clock-output-names: Name of the pixel clock created
 
+- mode: Defines which encoder will be enabled. Values are 'rgb', 'lvds'.
+  Defaults to 'rgb' if not set.
+
 - ports: A ports node with endpoint definitions as defined in
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoint, the second one the output
-- 
2.9.3
