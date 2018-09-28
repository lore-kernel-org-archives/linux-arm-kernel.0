From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:35 +0200
Subject: [PATCH 20/21] dt-bindings: timer: renesas: tmu: document R8A779{7|8}0
 bindings
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <5851fa4d088747af4a141110541594a2a4479b12.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the Renesas TMU bindings;
the TMU hardware in those is the Renesas standard 3-channel timer unit.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
index cd5f20bf2582..4ddff85837da 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
@@ -12,6 +12,8 @@ Required Properties:
     - "renesas,tmu-r8a7740" for the r8a7740 TMU
     - "renesas,tmu-r8a7778" for the r8a7778 TMU
     - "renesas,tmu-r8a7779" for the r8a7779 TMU
+    - "renesas,tmu-r8a77970" for the r8a77970 TMU
+    - "renesas,tmu-r8a77980" for the r8a77980 TMU
     - "renesas,tmu" for any TMU.
       This is a fallback for the above renesas,tmu-* entries
 
-- 
2.11.0
