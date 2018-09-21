From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 21 Sep 2018 19:08:28 +0100
Subject: [PATCH 2/5] dt-bindings: display: renesas: du: Document the r8a7744
 bindings
In-Reply-To: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1537553311-8831-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1537553311-8831-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Document the RZ/G1N (R8A7744) SoC in the R-Car DU bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 2b28ae2..aad9cf1 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -4,6 +4,7 @@ Required Properties:
 
   - compatible: must be one of the following.
     - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
+    - "renesas,du-r8a7744" for R8A7744 (RZ/G1N) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a77470" for R8A77470 (RZ/G1C) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
@@ -51,6 +52,7 @@ corresponding to each DU output.
                         Port0          Port1          Port2          Port3
 -----------------------------------------------------------------------------
  R8A7743 (RZ/G1M)       DPAD 0         LVDS 0         -              -
+ R8A7744 (RZ/G1N)       DPAD 0         LVDS 0         -              -
  R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
  R8A77470 (RZ/G1C)      DPAD 0         DPAD 1         LVDS 0         -
  R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
-- 
2.7.4
