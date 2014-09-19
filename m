From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Sep 2014 13:14:15 +0900
Subject: [PATCH 2/2] ARM: shmobile: Add manufacturer for KZM boards
In-Reply-To: <cover.1411099817.git.horms+renesas@verge.net.au>
References: <cover.1411099817.git.horms+renesas@verge.net.au>
Message-ID: <08adafd4a1f8c9b6e2c49d955a0e45743c9ffd9a.1411099817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

KZM-A9-Dual and KZM-A9-GT are manufactured by Kyoto Microcomputer Co.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 5d1c5c0..51147cb 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -53,11 +53,11 @@ Boards:
     compatible = "renesas,henninger", "renesas,r8a7791"
   - Koelsch (RTP0RC7791SEB00010S)
     compatible = "renesas,koelsch", "renesas,r8a7791"
-  - KZM9D
+  - Kyoto Microcomputer Co. KZM-A9-Dual
     compatible = "renesas,kzm9d", "renesas,emev2"
-  - KZM-A9-GT
+  - Kyoto Microcomputer Co. KZM-A9-GT
     compatible = "renesas,kzm9g", "renesas,sh73a0"
-  - KZM-A9-GT - Reference Device Tree Implementation
+  - Kyoto Microcomputer Co. KZM-A9-GT - Reference Device Tree Implementation
     compatible = "renesas,kzm9g-reference", "renesas,sh73a0"
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
-- 
2.0.1
