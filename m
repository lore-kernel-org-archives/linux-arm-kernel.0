From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  6 Jun 2017 16:10:16 +0100
Subject: [PATCH v2 3/5] ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M
 board
In-Reply-To: <1496761818-62126-1-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-4-git-send-email-biju.das@bp.renesas.com>
 <1496761818-62126-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1496761818-62126-4-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the iW-RainboW-G20D-Qseven-RZG1M device tree bindings,
listing it as a supported board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index ace4fe3..9b6f6cc 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -63,6 +63,8 @@ Boards:
     compatible = "renesas,h3ulcb", "renesas,r8a7795";
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
+  - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
+    compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743"
   - iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
     compatible = "iwave,g20m", "renesas,r8a7743"
   - Koelsch (RTP0RC7791SEB00010S)
-- 
1.9.1
