From: kbingham@kernel.org (Kieran Bingham)
Date: Thu, 15 Feb 2018 08:38:17 +0000
Subject: [PATCH 2/8] dt-bindings: display: renesas,
 du: Document r8a77995 bindings
In-Reply-To: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
Message-ID: <1518683903-10681-3-git-send-email-kbingham@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Document the D3 (r8a77995) SoC in the R-Car DU bindings.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 8f6e0e118e3e..56f67453b9aa 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,du-r8a7794" for R8A7794 (R-Car E2) compatible DU
     - "renesas,du-r8a7795" for R8A7795 (R-Car H3) compatible DU
     - "renesas,du-r8a7796" for R8A7796 (R-Car M3-W) compatible DU
+    - "renesas,du-r8a77995" for R8A77995 (R-Car D3) compatible DU
 
   - reg: A list of base address and length of each memory resource, one for
     each entry in the reg-names property.
@@ -60,6 +61,7 @@ corresponding to each DU output.
  R8A7794 (R-Car E2)   DPAD 0         DPAD 1         -              -
  R8A7795 (R-Car H3)   DPAD 0         HDMI 0         HDMI 1         LVDS 0
  R8A7796 (R-Car M3-W) DPAD 0         HDMI 0         LVDS 0         -
+ R8A77995 (R-Car D3)  DPAD 0         LVDS 0         LVDS 1         -
 
 
 Example: R8A7795 (R-Car H3) ES2.0 DU
-- 
2.7.4
