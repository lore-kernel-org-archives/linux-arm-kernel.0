From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  2 Jun 2017 17:22:01 +0100
Subject: [PATCH 2/4] ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M board
In-Reply-To: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
References: <1496420523-23506-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1496420523-23506-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the iW-RainboW-G20D-Qseven-RZG1M device tree bindings,
listing it as a supported board.

This allows to use checkpatch.pl to validate .dts files referring to the
iW-RainboW-G20D-Qseven-RZG1M board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 4b60ce2..13fbfe0 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -69,6 +69,8 @@ Boards:
     compatible = "renesas,kzm9d", "renesas,emev2"
   - Kyoto Microcomputer Co. KZM-A9-GT
     compatible = "renesas,kzm9g", "renesas,sh73a0"
+  - iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
+    compatible = "iwave,g20d", "renesas,r8a7743"
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
   - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKB00010S)
-- 
1.9.1
