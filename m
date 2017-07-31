From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:04:27 +0200
Subject: [PATCH 1/5] dt-bindings: display: renesas: Add R-Car M3-W HDMI TX DT
 bindings
In-Reply-To: <cover.1501512759.git.horms+renesas@verge.net.au>
References: <cover.1501512759.git.horms+renesas@verge.net.au>
Message-ID: <b2e2df8e7143682ae0888215e6cdb99da1a585c5.1501512759.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The M3-W HDMI TX controller seems to be compatible for the H3. No
extension to the DT bindings are needed, add an SoC-specific compatible
string in case differences between the IP versions are found later and
require model-specific handling.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
index 81b68580e199..83382a422f30 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
@@ -13,6 +13,7 @@ Required properties:
 
 - compatible : Shall contain one or more of
   - "renesas,r8a7795-hdmi" for R8A7795 (R-Car H3) compatible HDMI TX
+  - "renesas,r8a7796-hdmi" for R8A7796 (R-Car M3-W) compatible HDMI TX
   - "renesas,rcar-gen3-hdmi" for the generic R-Car Gen3 compatible HDMI TX
 
     When compatible with generic versions, nodes must list the SoC-specific
-- 
2.1.4
