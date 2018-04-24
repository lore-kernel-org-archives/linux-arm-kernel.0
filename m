From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 07:54:42 +0200
Subject: [PATCH] dt-bindings: arm: consistently name r8a77965 as M3-N
Message-ID: <20180424055442.19710-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an inconsistency between the use of M3N and M3-N.
This patch resolves this by consistently using the latter.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20180423-v4.17-rc2
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 61b486fb5793..02c5d261683f 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -116,7 +116,7 @@ Boards:
     compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
     compatible = "renesas,salvator-x", "renesas,r8a7796"
-  - Salvator-X (RTP0RC7796SIPB0011S (M3N))
+  - Salvator-X (RTP0RC7796SIPB0011S (M3-N))
     compatible = "renesas,salvator-x", "renesas,r8a77965"
   - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
     compatible = "renesas,salvator-xs", "renesas,r8a7795"
-- 
2.11.0
