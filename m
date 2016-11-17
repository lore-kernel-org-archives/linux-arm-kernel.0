From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 14:34:46 +0100
Subject: [PATCH 2/2] ARM: shmobile: document SK-RZG1E board
In-Reply-To: <cover.1479387356.git.horms+renesas@verge.net.au>
References: <cover.1479387356.git.horms+renesas@verge.net.au>
Message-ID: <4af239175d00c1866cc6b41f3eabcf93c45dcc40.1479387356.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document the SK-RZG1E device tree bindings, listing it as a supported board.

This allows to use checkpatch.pl to validate .dts files referring to the
SK-RZG1E board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 0af01f9a01f4..3c7acf22957a 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -77,6 +77,8 @@ Boards:
     compatible = "renesas,salvator-x", "renesas,r8a7796";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
+  - SK-RZG1E (YR8A77450S000BE)
+    compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
   - SK-RZG1M (YR8A77430S000BE)
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
   - Wheat
-- 
2.7.0.rc3.207.g0ac5344
