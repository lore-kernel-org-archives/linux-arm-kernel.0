From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:53 +0200
Subject: [PATCH 6/8] arm: shmobile: Document Kingfisher board DT bindings
In-Reply-To: <cover.1506676368.git.horms+renesas@verge.net.au>
References: <cover.1506676368.git.horms+renesas@verge.net.au>
Message-ID: <5418a9004126992aa2bbd07d79e8305659cb0dc9.1506676368.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Add Kingfisher Device tree bindings Documentation, listing it as a
supported board.
Kingfisher is the H3ULCB/M3ULCB extension board.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index a1f06711a4dd..e9bd3091dcf6 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -78,6 +78,8 @@ Boards:
     compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
   - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
     compatible = "iwave,g20m", "renesas,r8a7743"
+  - Kingfisher (SBEV-RCAR-KF-M03)
+    compatible = "shimafuji,kingfisher"
   - Koelsch (RTP0RC7791SEB00010S)
     compatible = "renesas,koelsch", "renesas,r8a7791"
   - Kyoto Microcomputer Co. KZM-A9-Dual
-- 
2.1.4
