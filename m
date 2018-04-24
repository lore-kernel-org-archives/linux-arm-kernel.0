From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 24 Apr 2018 19:04:23 +0530
Subject: [RFC 11/13] bindings: display: Add compatible for A64 tcon-tv
In-Reply-To: <20180424133425.24291-1-jagan@amarulasolutions.com>
References: <20180424133425.24291-1-jagan@amarulasolutions.com>
Message-ID: <20180424133425.24291-12-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tcon-tv on Allwinner A64 has similar behavior like Allwinner A83T.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 3576006e9dbb..cf7c7e535d9c 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -151,6 +151,7 @@ Required properties:
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
    * allwinner,sun50i-a64-tcon-lcd
+   * allwinner,sun50i-a64-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
-- 
2.14.3
