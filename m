From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Dec 2017 20:22:36 +0800
Subject: [PATCH v3 04/11] dt-bindings: simplefb-sunxi: add pipelines for DE2
In-Reply-To: <20171222122243.25735-1-icenowy@aosc.io>
References: <20171222122243.25735-1-icenowy@aosc.io>
Message-ID: <20171222122243.25735-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're going to add simplefb support for Allwinner SoCs with DE2, add
suitable pipeline strings in the device tree binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Adds Rob's ACK.

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
2.14.2
