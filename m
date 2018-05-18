From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:46 +0200
Subject: [PATCH 4/6] dt-bindings: arm: consistently name r8a77965 as M3-N
In-Reply-To: <cover.1526549153.git.horms+renesas@verge.net.au>
References: <cover.1526549153.git.horms+renesas@verge.net.au>
Message-ID: <519df0e05d2796805ee6d6e396423e60f3743b97.1526549153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an inconsistency between the use of M3N and M3-N.
This patch resolves this by consistently using the latter.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 804f1d7c1f2b..0da876784dd5 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -114,7 +114,7 @@ Boards:
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
