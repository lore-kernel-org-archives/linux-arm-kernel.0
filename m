From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:49 +0530
Subject: [PATCH 12/21] bindings: display: Add compatible for A64 tcon-tv
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-13-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tcon-tv on Allwinner A64 has similar behavior like Allwinner A83T.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 5d448ef2132f..8b6b4bc43d98 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -150,6 +150,7 @@ Required properties:
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
+   * allwinner,sun50i-a64-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
-- 
2.14.3
