From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 11 Sep 2017 23:55:26 +0800
Subject: [PATCH 1/4] dt-bindings: simplefb-sunxi: add pipelines for DE2
In-Reply-To: <20170911155529.62891-1-icenowy@aosc.io>
References: <20170911155529.62891-1-icenowy@aosc.io>
Message-ID: <20170911155529.62891-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're going to add simplefb support for Allwinner SoCs with DE2, add
suitable pipeline strings in the device tree binding.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/display/simple-framebuffer-sunxi.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-sunxi.txt
index a9168ae6946c..d693b8dc9a62 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer-sunxi.txt
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer-sunxi.txt
@@ -15,6 +15,10 @@ Required properties:
   "de_be1-lcd1"
   "de_be0-lcd0-hdmi"
   "de_be1-lcd1-hdmi"
+  "mixer0-lcd0"
+  "mixer0-lcd0-hdmi"
+  "mixer1-lcd1-hdmi"
+  "mixer1-lcd1-tve"
 
 Example:
 
-- 
2.13.5
